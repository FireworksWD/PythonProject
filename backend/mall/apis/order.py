import time
from datetime import datetime

from django.db import transaction
from ninja import Query, Router, Schema
from typing import List

from mall.models import Cart, Order, Address, OrderDetail, Product
from loguru import logger

from utils.fu_response import FuResponse
from utils.usual import get_user_info_from_token
from system.models import Users
from django.utils import timezone
from django.db.models import F

router = Router()


class OrderSchema(Schema):
    id: int
    order_number: str
    username: str
    total_amount: float
    payment_amount: float
    payment_status: int
    transaction_status: int
    recipient_phone: str
    recipient_address: str
    create_time: datetime
    checkout_time: datetime
    user_id: int


class PageOrderSchemaOut(Schema):
    page: int = None
    pageSize: int = None
    total: int = None
    data: List[OrderSchema]


class OrderDetailSchemaOut(Schema):
    id: int = None
    img_url: str = None
    shop_price: float = None
    shop_name: str = None
    order_number: int = None
    user_id: int = None
    shop_id: int = None
    is_delete: int = None
    create_time: datetime = None
    product_num:int=None


# 订单查询
@router.get('/order/v1/list', auth=None, response=PageOrderSchemaOut)
def get_order_list(request, currentPage: int = Query(1), pageSize: int = Query(6), keyword: str = Query(None)):
    user = get_user_info_from_token(request)
    if keyword:
        filters = {'order_number__icontains': keyword}
        total = Order.objects.filter(user_id=user['id']).filter(**filters).all().count()
        qs = Order.objects.filter(user_id=user['id']).filter(**filters).order_by('-create_time').all()[
             (currentPage - 1) * pageSize:currentPage * pageSize]
        return {"total": total, "page": currentPage, "pageSize": pageSize, "data": list(qs)}
    else:
        total = Order.objects.filter(user_id=user['id']).all().count()
        qs = Order.objects.filter(user_id=user['id']).order_by('-create_time').all()[
             (currentPage - 1) * pageSize:currentPage * pageSize]
        return {"total": total, "page": currentPage, "pageSize": pageSize, "data": list(qs)}


# 订单详情
@router.get('/order/v1/detail', auth=None, response=List[OrderDetailSchemaOut])
def get_order_detail(request, order_number: str = Query(...),user_id:int=Query(None)):
    user = get_user_info_from_token(request)
    user_ids = user_id if user_id else user['id']
    qs = OrderDetail.objects.filter(user_id=user_ids, order_number=order_number, is_delete=0).all()
    if qs:
        return qs
    return []


# 增加订单
@router.get('/order/v1/submit', auth=None)
def submit_order(request):
    user = get_user_info_from_token(request)
    try:
        with transaction.atomic():
            order_number = str(int(time.time()))
            cart_list = Cart.objects.filter(user_id=user['id']).all()
            address = Address.objects.filter(user_id=user['id'], is_default=1).first()
            if not address:
                return FuResponse(code=249)
            pay_amount = 0
            add_order_detail_list = []
            for cart in cart_list:
                item = {'img_url': cart.img_url, 'product_num': cart.product_num, 'shop_price': cart.shop_price,
                        'shop_name': cart.shop_name, 'order_number': order_number, 'user_id': user['id'],
                        'shop_id': cart.shop_id}
                add_order_detail_list.append(OrderDetail(**item))
                pay_amount = (cart.product_num * cart.shop_price) + pay_amount
            logger.info('开始创建')
            OrderDetail.objects.bulk_create(add_order_detail_list)
            logger.info('成功')
            Cart.objects.filter(user_id=user['id']).delete()
            # logger.info({
            #     'username': user['username'],
            #     'total_amount': pay_amount,
            #     'payment_amount': pay_amount,
            #     'transaction_status': 0,
            #     'recipient_phone': address.contact_number,
            #     'recipient_address': address.delivery_address + '/' + address.detailed_address,
            #     'user_id': user['id']
            # })
            Order.objects.create(
                order_number=order_number,
                username=address.username,
                total_amount=pay_amount,
                payment_amount=pay_amount,
                transaction_status=0,
                recipient_phone=address.contact_number,
                recipient_address=address.delivery_address + '/' + address.detailed_address,
                checkout_time=timezone.now(),
                user_id=user['id']
            )
    except Exception as e:
        logger.info(e)
        # 处理事务失败时的情况
        return FuResponse(code=599, msg='操作失败')
    # 如果没有异常发生，返回成功的响应
    return FuResponse(code=200, msg='successfully!!!')


# 取消订单
@router.get('/order/v1/cancel', auth=None)
def cancel_order(request, orderId: int = Query(...)):
    user = get_user_info_from_token(request)
    try:
        with transaction.atomic():
            Order.objects.filter(user_id=user['id'], id=orderId).update(payment_status=0, transaction_status=2)
    except Exception as e:
        logger.info(e)
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')
    # 如果没有异常发生，返回成功的响应
    return FuResponse(code=200, msg='successfully!!!')


# 付款
@router.get('/order/v1/pay', auth=None)
def order_pay(request, orderId: int = Query(...)):
    user = get_user_info_from_token(request)
    try:
        with transaction.atomic():
            Order.objects.filter(user_id=user['id'], id=orderId).update(payment_status=1, transaction_status=0)
    except Exception as e:
        logger.info(e)
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')
    # 如果没有异常发生，返回成功的响应
    return FuResponse(code=200, msg='successfully!!!')


# 删除订单
@router.get('/order/v1/del', auth=None)
def delete_order(request, orderId: int = Query(...), order_number: str = Query(...)):
    user = get_user_info_from_token(request)
    try:
        with transaction.atomic():
            qs = OrderDetail.objects.filter(user_id=user['id'], order_number=order_number, is_delete=0).all()
            for item in qs:
                Product.objects.filter(id=item.shop_id).update(
                    number=item.product_num + F('number'))
            OrderDetail.objects.filter(user_id=user['id'], order_number=order_number, is_delete=0).update(is_delete=1)
            Order.objects.filter(user_id=user['id'], id=orderId).delete()
    except Exception as e:
        logger.info(e)
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')
    # 如果没有异常发生，返回成功的响应
    return FuResponse(code=200, msg='successfully!!!')


# 管理端订单查询
@router.get('/order/v1/ad/list', auth=None, response=PageOrderSchemaOut)
def get_order_list(request, currentPage: int = Query(1), pageSize: int = Query(6), keyword: str = Query(None),
                   username: str = Query(None)):
    user = get_user_info_from_token(request)
    user_instance = Users.objects.get(username=user['username'])

    # 查询角色
    if user['id'] != 1:
        user_roles = user_instance.role.all()
        if any(role.id == 3 for role in user_roles):
            return FuResponse(code=304, msg='没有权限')

    filters = {}
    if keyword:
        filters['order_number__icontains'] = keyword
    if username:
        filters['username__icontains'] = username

    total = Order.objects.filter(**filters).count()
    qs = Order.objects.filter(**filters).order_by('-create_time')[(currentPage - 1) * pageSize:currentPage * pageSize]

    return {
        "total": total,
        "page": currentPage,
        "pageSize": pageSize,
        "data": list(qs)
    }


# 管理员提交订单
@router.get('/order/v1/ad/update', auth=None)
def update_order_by_id(request, id: int = Query(...)):
    user = get_user_info_from_token(request)
    user_instance = Users.objects.get(username=user['username'])

    # 查询角色
    if user['id'] != 1:
        user_roles = user_instance.role.all()
        if any(role.id == 3 for role in user_roles):
            return {"code": 304, "msg": "没有权限"}
    Order.objects.filter(id=id).update(transaction_status=1)
    return {"code": 200}


# 取消订单
@router.get('/order/v1/ad/cancel', auth=None)
def update_order_by_id(request, id: int = Query(...)):
    user = get_user_info_from_token(request)
    user_instance = Users.objects.get(username=user['username'])

    # 查询角色
    if user['id'] != 1:
        user_roles = user_instance.role.all()
        if any(role.id == 3 for role in user_roles):
            return {"code": 304, "msg": "没有权限"}
    Order.objects.filter(id=id).update(transaction_status=0)
    return {"code": 200}
