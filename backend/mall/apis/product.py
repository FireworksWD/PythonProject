import os
from datetime import datetime

import loguru
from django.db import transaction
from django.db.models import F
from ninja import Query, Router, Body, Schema
from typing import List

from ninja.security import django_auth

from fuadmin.settings import MEDIA_URL
from mall.MallSchema import ProductSchema, PageProductSchemaOut, ChangeProductSchema, PageCartSchemaOut
from mall.models import Cart, Product, CateGory, KeywordHot, HotProduct
from loguru import logger
from system.models import Users, Role
from django.contrib.auth.hashers import make_password

from utils.fu_response import FuResponse
from utils.usual import get_user_info_from_token
from ninja import File as NinjaFile
from ninja.files import UploadedFile

router = Router()


# 关键字搜索
def keyword_create_update(keyword):
    qs = KeywordHot.objects.filter(keyword=keyword).first()
    if qs:
        KeywordHot.objects.filter(keyword=keyword).update(num=F('num') + 1)
    else:
        KeywordHot.objects.create(keyword=keyword, num=1)


def product_hit_c_u(pid, product):
    qs = HotProduct.objects.filter(pid=pid).first()
    if qs:
        HotProduct.objects.filter(pid=pid).update(hit=F('hit') + 1)
    else:
        HotProduct.objects.create(pid=pid, product=product,hit=1)


class QueryProductIn(Schema):
    shop_name: str = None


# 用户注册
class RegisterSchemaIn(Schema):
    username: str
    password: str


@router.post('/register', auth=None)
def user_register(request, data: RegisterSchemaIn):
    try:
        role, created = Role.objects.get_or_create(id=3)
        new_user = Users.objects.create(
            name='common',
            username=data.username,
            password=make_password(data.password),
            status=True
        )
        new_user.role.add(role)
        return FuResponse(code=200, msg='注册成功!!!')
    except Exception as e:
        return FuResponse(code=599, msg='用户已存在!!!')


# 商品分类的数据
@router.get('/product_list', response=PageProductSchemaOut, auth=None)
def get_product_list(request, currentPage: int = Query(1), pageSize: int = Query(10), categoryid: str = Query(...)):
    # 查询参数
    categoryName = CateGory.objects.filter(id=categoryid).first().categoryName
    filters = {'categoryName__icontains': categoryName}
    total = Product.objects.filter(**filters).count()
    product_list = Product.objects.filter(**filters).order_by('-create_time')[
                   (currentPage - 1) * pageSize:currentPage * pageSize]
    return {"total": total, "page": currentPage, "pageSize": pageSize, "data": list(product_list)}


# 根据分页返回的数据
@transaction.atomic()
@router.get('/product/v1/list', auth=None, response=PageProductSchemaOut)
def get_product_all(request, currentPage: int = Query(1), pageSize: int = Query(10), keyword: str = Query("")):
    if not keyword:
        total = Product.objects.all().count()
        product_list = Product.objects.filter(number__gt=0).all().order_by('-create_time')[
                       (currentPage - 1) * pageSize:currentPage * pageSize]
        return {"total": total, "page": currentPage, "pageSize": pageSize, "data": list(product_list)}
    else:
        keyword_create_update(keyword)
        filters = {'name__icontains': keyword}
        total = Product.objects.filter(**filters).count()
        product_list = Product.objects.filter(number__gt=0,**filters).order_by('-create_time')[
                       (currentPage - 1) * pageSize:currentPage * pageSize].all()
        return {"total": total, "page": currentPage, "pageSize": pageSize, "data": list(product_list)}


# 商品详情
@transaction.atomic()
@router.get('/product/v1', response=ProductSchema, auth=None)
def get_product_detail_by_id(request, product_id: int = Query(None)):
    user_info = get_user_info_from_token(request)
    user = Users.objects.filter(id=user_info['id']).first()
    if user:
        if product_id:
            qs = Product.objects.filter(id=product_id).first()
            # 角色
            user_instance = Users.objects.get(username=user_info['username'])
            user_roles = user_instance.role.all()
            for role in user_roles:
                #
                if role.id == 3:
                    product_hit_c_u(product_id, qs.name)
            return qs
    else:
        return FuResponse(code=500, msg='操作失败')


# 销售员和管理员对数据进行管理所返回的数据
@router.get('/product_list_id', response=PageProductSchemaOut, auth=None)
def get_product_list_by_id(request, page: int = Query(1), pageSize: int = Query(10),
                           keyword: str = Query(None)):
    # 查询参数
    filters = {}
    if keyword:
        filters['name__icontains'] = keyword
    # 获取当前用户
    user_info = get_user_info_from_token(request)
    user_instance = Users.objects.get(username=user_info['username'])
    if user_info['id'] == 1:
        total = Product.objects.filter(**filters).count()
        product_list = Product.objects.filter(**filters).order_by('-create_time')[
                       (page - 1) * pageSize:page * pageSize]
        return {"total": total, "page": page, "pageSize": pageSize, "data": list(product_list)}
    # 查询角色
    user_roles = user_instance.role.all()
    for role in user_roles:
        # 销售员
        if role.id == 2:
            total = Product.objects.filter(user_id=user_info['id']).filter(**filters).count()
            product_list = Product.objects.filter(user_id=user_info['id']).filter(**filters).order_by('-create_time')[
                           (page - 1) * pageSize:page * pageSize]
            return {"total": total, "page": page, "pageSize": pageSize, "data": list(product_list)}


# 修改商品数据
@router.put('/product/v1/update', auth=None)
def change_product_by_id(request, product_id: int = Query(...), kwargs: ChangeProductSchema = Body(None)):
    user_info = get_user_info_from_token(request)
    user_id = user_info['id']
    update_data = None
    res = None
    if kwargs:
        # 构建一个字典，包含 ChangeProductSchema 中的非空字段
        update_data = {key: value for key, value in kwargs.dict().items() if value and key != 'img_url'}
        # 检查当前的是否有重复
        if update_data['name']:
            del update_data['name']
        # if update_data['name']:
        #     check = Product.objects.filter(user_id=user_id, name=update_data['name']).first()
        #     if check:
        #         return {"code": 399}
    if user_id == 1 and update_data:
        # 只有在 update_data 不为空时才执行更新
        # 根据 product_id 过滤记录并更新
        res = Product.objects.filter(id=product_id).update(**update_data)
        return res
    user_instance = Users.objects.get(username=user_info['username'])
    # 查询角色
    user_roles = user_instance.role.all()
    for role in user_roles:
        # 销售员
        if role.id == 2:
            res = Product.objects.filter(user_id=user_id, id=product_id).update(**update_data)
            break
    return res


# 删除商品
@router.delete('/product/v1/del', auth=None)
def delete_product_by_id(request, product_id: int = Query(...)):
    user_info = get_user_info_from_token(request)
    user_id = user_info['id']
    if user_id == 1:
        Product.objects.filter(id=product_id).delete()
        # 如果没有异常发生，返回成功的响应
        return {"code": 200}
    else:
        user_instance = Users.objects.get(username=user_info['username'])
        # 查询角色
        user_roles = user_instance.role.all()
        for role in user_roles:
            # 销售员
            if role.id == 2:
                Product.objects.filter(user_id=user_id, id=product_id).delete()
                # 如果没有异常发生，返回成功的响应
                return {"code": 200}
        # 处理事务失败时的情况
    return {"code": 500}


# 增加商品
@router.post('/product/v1/add', auth=None)
def add_product_by_id(request, kwargs: ChangeProductSchema = Body(...)):
    user = get_user_info_from_token(request)
    # 验证必需字段
    required_fields = ['price', 'number', 'name', 'description', 'categoryName']
    missing_fields = [field for field in required_fields if getattr(kwargs, field) is None]

    if missing_fields:
        error_message = f"Missing required fields: {', '.join(missing_fields)}"
        return {"status": 100, "msg": error_message}
    create_data = {"price": kwargs.price, "number": kwargs.number, "user_id": user['id'], "name": kwargs.name,
                   "description": kwargs.description, "categoryName": kwargs.categoryName, "img_url": kwargs.img_url}
    logger.info(create_data)
    check = Product.objects.filter(user_id=user['id'], name=create_data['name']).first()
    if check:
        return {"code": 399}
    else:
        Product.objects.create(**create_data)
        return {"code": 200, "msg": "successfully"}


# 修改或者上传图片
@router.post("/product/v1/upload", auth=None)
def upload(request, id: str = Query(None), file: UploadedFile = NinjaFile(...)):
    try:
        binary_data = file.read()
        current_date = datetime.now().strftime('%Y%m%d%H%M%S%f')
        current_ymd = datetime.now().strftime('%Y%m%d')
        file_name = current_date + '_' + file.name.replace(' ', '_')
        file_path = os.path.join(MEDIA_URL + '/images/', current_ymd)
        if not os.path.exists(file_path):
            os.makedirs(file_path)
        file_url = os.path.join(file_path, file_name).replace('\\', '/')
        with open(file_url, 'wb') as f:
            f.write(binary_data)
        path = 'images/' + current_ymd + '/' + file_name
        if id:
            Product.objects.filter(id=id).update(img_url=path)
        return {"code": 200, "id": id, "img_url": 'images/' + current_ymd + '/' + file_name}
    except Exception as e:
        logger.info(e)


# 购物车数据查询
@router.get('/cart', response=PageCartSchemaOut, auth=None)
def get_cart_list_by_id(request, page: int = Query(1), pageSize: int = Query(10),
                        query: QueryProductIn = Body(None)):
    user_info = get_user_info_from_token(request)
    user_id = user_info['id']
    total = Cart.objects.filter(user_id=user_id).count()
    qs = Cart.objects.filter(user_id=user_id).order_by('-create_time')[
         (page - 1) * pageSize:page * pageSize]
    return {"total": total, "page": page, "pageSize": pageSize, "data": list(qs)}


# 轮播图
@router.get('/product/v1/random', auth=None, response=List[ProductSchema])
def get_random_img(request):
    random_products = Product.objects.order_by('?')[:4]  # 随机选择4个产品
    return random_products
