import os
from datetime import datetime

from django.db import transaction
from ninja import Query, Router, Schema
from typing import List
from django.db.models import Q
from fuadmin.settings import MEDIA_URL
from mall.models import  MsgHistory
from loguru import logger
from system.models import Users
from utils.usual import get_user_info_from_token
from ninja import File as NinjaFile
from ninja.files import UploadedFile

router = Router()


class SchemaOut(Schema):
    id: int
    uid: int
    username: str
    dateTime: str
    text: str
    read_state: int
    receive_user: str
    img: str


class UserSchemaOut(Schema):
    username: str


@router.get('/msg/v1/usr', auth=None, response=List[UserSchemaOut])
def get_user_list(request):
    qs = MsgHistory.objects.exclude(username__icontains='customer').values('username').order_by('username').distinct().all()
    return qs


# 客服
@router.get('/msg/v1/customer', auth=None, response=List[UserSchemaOut])
def get_user_list(request):
    qs = Users.objects.filter(role__id=2).values('username').order_by('username').distinct()
    return qs


# 获取最近客服端的历史记录20条
@router.get('/msg/v1/cu/list', auth=None, response=List[SchemaOut])
def get_msg_list(request, username=Query(...)):
    user_info = get_user_info_from_token(request)
    customer_username = user_info['username']
    query = Q(username=username, receive_user=customer_username) | Q(username=customer_username, receive_user=username)
    qs = MsgHistory.objects.filter(query).order_by('-dateTime').all()[:20]
    return qs


# 获取用户端最近的历史记录20条
@router.get('/msg/v1/cn/list', auth=None, response=List[SchemaOut])
def get_msg_common_list(request,customer_username=Query(...)):
    user_info = get_user_info_from_token(request)
    username = user_info['username']
    query = Q(username=username, receive_user=customer_username) | Q(username=customer_username, receive_user=username)
    qs = MsgHistory.objects.filter(query).order_by(
        '-dateTime').all()[:20]
    return qs


# 修改普通用户图片
@transaction.atomic()
@router.post('/user/v1/img', auth=None)
def update_user_img(request, file: UploadedFile = NinjaFile(...)):
    try:
        uid = get_user_info_from_token(request)['id']
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
        Users.objects.filter(id=uid).update(avatars=path)
        img = 'http://localhost:8088/media/images/' + current_ymd + '/' + file_name
        check = MsgHistory.objects.filter(uid=uid).first()
        if check:
            MsgHistory.objects.filter(uid=uid).update(img=img)
        return {"code": 200, "id": uid, "img_url": img}
    except Exception as e:
        logger.info(e)
