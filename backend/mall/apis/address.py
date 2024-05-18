from datetime import datetime

from django.db import transaction
from ninja import Query, Router, Body, Schema
from typing import List

from mall.models import  Address
from loguru import logger

from utils.fu_response import FuResponse
from utils.usual import get_user_info_from_token

router = Router()


class AddressOut(Schema):
    id: int
    username: str
    contact_number: str
    delivery_address: str
    detailed_address: str
    is_default: int
    create_time: datetime
    user_id: int


class PageAddressSchemaOut(Schema):
    page: int = None
    pageSize: int = None
    total: int = None
    data: List[AddressOut]


# 获取地址信息
@router.get('/address/v1/list', auth=None, response=PageAddressSchemaOut)
def get_address_list(request, currentPage: int = Query(1), pageSize: int = Query(5)):
    if not request:
        return FuResponse(code=500)
    user = get_user_info_from_token(request)
    total = Address.objects.filter(user_id=user['id']).all().count()
    qs = Address.objects.filter(user_id=user['id']).order_by('-create_time').all()[
         (currentPage - 1) * pageSize:currentPage * pageSize]
    return {"total": total, "page": currentPage, "pageSize": pageSize, "data": list(qs)}


class AddressIn(Schema):
    id: int = None
    username: str = None
    contact_number: str = None
    delivery_address: str = None
    detailed_address: str = None
    is_default: int = None


# 增加地址
@router.post('/address/v1/add', auth=None)
def add_address(request, kwargs: AddressIn = Body(None)):
    user = get_user_info_from_token(request)
    try:
        with transaction.atomic():
            if kwargs.is_default == 1:
                Address.objects.filter(user_id=user['id']).update(is_default=0)
            Address.objects.create(
                username=kwargs.username,
                contact_number=kwargs.contact_number,
                delivery_address=kwargs.delivery_address,
                detailed_address=kwargs.detailed_address,
                is_default=kwargs.is_default,
                user_id=user['id']
            )
    except Exception as e:
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')
    # 如果没有异常发生，返回成功的响应
    return FuResponse(code=200, msg='successfully!!!')


# 修改地址
@router.put('/address/v1/update', auth=None)
def change_address(request, kwargs: AddressIn = Body(None)):
    user = get_user_info_from_token(request)
    try:
        with transaction.atomic():
            if kwargs:
                if kwargs.is_default == 1:
                    Address.objects.filter(user_id=user['id']).update(is_default=0)
                if kwargs.id:
                    logger.info(kwargs.id)
                    # 构建一个字典，包含非空字段
                    update_data = {key: value for key, value in kwargs.dict().items() if value}
                    Address.objects.filter(user_id=user['id'], id=kwargs.id).update(**update_data)
                else:
                    Address.objects.create(
                        username=kwargs.username,
                        contact_number=kwargs.contact_number,
                        delivery_address=kwargs.delivery_address,
                        detailed_address=kwargs.detailed_address,
                        is_default=kwargs.is_default,
                        user_id=user['id']
                    )
    except Exception as e:
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')
    # 如果没有异常发生，返回成功的响应
    return FuResponse(code=200, msg='successfully!!!')


# 删除地址
@router.delete('/address/v1/delete', auth=None)
def delete_address(request, id: int = Query(...)):
    user = get_user_info_from_token(request)
    try:
        with transaction.atomic():
            Address.objects.filter(user_id=user['id'], id=id).delete()
    except Exception as e:
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')
    # 如果没有异常发生，返回成功的响应
    return FuResponse(code=200, msg='successfully!!!')
