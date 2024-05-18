from django.db import transaction
from ninja import Query, Router, Body, Schema
from typing import List

from mall.models import CateGory

from utils.fu_response import FuResponse
from utils.usual import get_user_info_from_token

router = Router()


class CateGoryOut(Schema):
    id: int
    categoryName: str


class PageCateGoryOut(Schema):
    page: int = None
    pageSize: int = None
    total: int = None
    data: List[CateGoryOut]


# 获取类型
@router.get('/v1/category_list', auth=None, response=List[CateGoryOut])
def get_category_list(request):
    qs = CateGory.objects.order_by('-create_time').all()
    return qs


# 分页获取
@router.get('/v1/category_page', response=PageCateGoryOut)
def get_category_list_page(request, currentPage: int = Query(1), pageSize: int = Query(10), keyword: str = Query(None)):
    user = get_user_info_from_token(request)
    if user['id'] != 1:
        return {"code": 304, "msg": "没有权限"}
    if keyword:
        filters = {'categoryName__icontains': keyword}
        total = CateGory.objects.filter(**filters).all().count()
        qs = CateGory.objects.filter(**filters).order_by('-create_time').all()[
             (currentPage - 1) * pageSize:currentPage * pageSize]
        return {"total": total, "page": currentPage, "pageSize": pageSize, "data": list(qs)}
    else:
        total = CateGory.objects.all().count()
        qs = CateGory.objects.order_by('-create_time').all()[
             (currentPage - 1) * pageSize:currentPage * pageSize]
        return {"total": total, "page": currentPage, "pageSize": pageSize, "data": list(qs)}


# 删除
@router.delete('/v1/category')
def del_category(request, id: str = Query(...)):
    user = get_user_info_from_token(request)
    if user['id'] != 1:
        return {"code": 304, "msg": "没有权限"}
    try:
        with transaction.atomic():
            CateGory.objects.filter(id=id).delete()
    except Exception as e:
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')
    # 如果没有异常发生，返回成功的响应
    return {"code": 200}


class SchemaIn(Schema):
    categoryName: str


# 增加
@router.post('/v1/category/add')
def add_category(request, kwargs: SchemaIn = Body(...)):
    user = get_user_info_from_token(request)
    if user['id'] != 1:
        return {"code": 304, "msg": "没有权限"}
    try:
        with transaction.atomic():
            CateGory.objects.create(**kwargs.dict())
    except Exception as e:
        # 处理事务失败时的情况
        return FuResponse(code=500, msg='操作失败')
    # 如果没有异常发生，返回成功的响应
    return {"code": 200}
