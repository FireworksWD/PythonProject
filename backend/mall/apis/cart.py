from datetime import datetime

from django.db import transaction
from ninja import Query, Router, Body, Schema
from typing import List

from mall.models import Cart, Product
from loguru import logger

from utils.fu_response import FuResponse
from utils.usual import get_user_info_from_token
from django.db.models import F

router = Router()


class CartOut(Schema):
    id: int
    img_url: str = None
    shop_name: str = None
    user_id: int = None
    shop_id: int = None
    shop_price: float = None
    create_time: datetime = None
    product_num: int = None
    username: str = None
    status: str = None


class PageCartOut(Schema):
    page: int = None
    pageSize: int = None
    total: int = None
    data: List[CartOut]


# 获取购物车数据
@router.get('/cart/v1/list', auth=None, response=PageCartOut)
def get_cart_list(request, currentPage: int = Query(1), pageSize: int = Query(6), keyword: str = Query(None)):
    if keyword:
        filters = {'shop_name__icontains': keyword}
        user = get_user_info_from_token(request)
        total = Cart.objects.filter(user_id=user['id']).filter(**filters).all().count()
        qs = Cart.objects.filter(user_id=user['id']).filter(**filters).order_by('-create_time').all()[
             (currentPage - 1) * pageSize:currentPage * pageSize]
        return {"total": total, "page": currentPage, "pageSize": pageSize, "data": list(qs)}
    else:
        user = get_user_info_from_token(request)
        total = Cart.objects.filter(user_id=user['id']).all().count()
        qs = Cart.objects.filter(user_id=user['id']).order_by('-create_time').all()[
             (currentPage - 1) * pageSize:currentPage * pageSize]
        return {"total": total, "page": currentPage, "pageSize": pageSize, "data": list(qs)}


class CartIn(Schema):
    userId: str
    productId: str
    productCount: int


# 添加到购物车
@router.post('/cart/v1/add', auth=None)
def create_cart(request, kwargs: CartIn = Body(...)):
    try:
        with transaction.atomic():
            product = Product.objects.select_for_update().get(id=kwargs.productId)
            user = get_user_info_from_token(request)
            logger.info(user)

            now_num = product.number
            Product.objects.filter(id=kwargs.productId).update(number=now_num - kwargs.productCount)

            cart, created = Cart.objects.get_or_create(
                shop_id=kwargs.productId,
                user_id=user['id'],
                defaults={
                    'img_url': product.img_url,
                    'shop_name': product.name,
                    'shop_price': product.price,
                    'product_num': kwargs.productCount,
                    'username': user['username'],
                    'status': '0'
                }
            )

            if not created:
                Cart.objects.filter(id=cart.id).update(product_num=F('product_num') + kwargs.productCount)

    except Exception as e:
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')

    # 如果没有异常发生，返回成功的响应
    return FuResponse(code=200, msg='successfully!!!')


# 删除购物车
@router.delete('/cart/v1/delete', auth=None)
def delete_cart(request, productId: int = Query(...), cartId: int = Query(...)):
    user = get_user_info_from_token(request)
    try:
        with transaction.atomic():
            check = Cart.objects.select_for_update().filter(shop_id=productId, user_id=user['id'], id=cartId).first()
            if check:
                product_num = check.product_num
                Product.objects.filter(id=productId).update(number=product_num + F('number'))
                Cart.objects.filter(id=cartId).delete()
    except Exception as e:
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')

    # 如果没有异常发生，返回成功的响应
    return FuResponse(code=200, msg='successfully!!!')


# 更改购物车操作
@router.put('/cart/v1/change', auth=None)
def put_cart(request, productId: int = Query(...), cartId: int = Query(...), num: int = Query(...)):
    user = get_user_info_from_token(request)
    try:
        with transaction.atomic():
            # 获取当前产品对象并锁定，确保获取的值是最新的
            product = Product.objects.select_for_update().get(id=productId)
            check = Cart.objects.select_for_update().filter(shop_id=productId, user_id=user['id'], id=cartId).first()
            if check:
                product_num = check.product_num
                now = product_num - num
                if product.number + now < 0:
                    # 库存不足，可以进行相应的处理，例如返回错误信息
                    return FuResponse(code=500, msg='库存不足')
                Product.objects.filter(id=productId).update(number=now + F('number'))
                Cart.objects.filter(shop_id=productId, user_id=user['id'], id=cartId).update(product_num=num)
    except Exception as e:
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')

        # 如果没有异常发生，返回成功的响应
    return FuResponse(code=200, msg='successfully!!!')
