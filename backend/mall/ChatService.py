import json
from datetime import datetime

from asgiref.sync import sync_to_async
from loguru import logger
from channels.generic.websocket import AsyncWebsocketConsumer
from channels.exceptions import StopConsumer
from typing import List, Dict

from fuadmin.settings import SECRET_KEY
from system.models import Users
from utils.fu_jwt import FuJwt
from mall.models import MsgHistory


class ConnectionManager:
    def __init__(self):
        # 存放激活的链接
        self.active_connections: List[Dict[str, AsyncWebsocketConsumer]] = []
        # 存放最近的50条消息
        self.recent_messages: List[Dict[str, str]] = []

    async def connect(self, user: str, consumer: AsyncWebsocketConsumer):
        # 链接
        await consumer.accept()
        self.active_connections.append({"user": user, "consumer": consumer})

    def disconnect(self, user: str, consumer: AsyncWebsocketConsumer):
        # 关闭时 移除consumer对象
        self.active_connections.remove({"user": user, "consumer": consumer})

    def add_recent_message(self, user: str, message: str, timestamp: str):
        # 添加最近的消息
        formatted_message = {"user": user, "message": message, "time": timestamp}
        self.recent_messages.append(formatted_message)
        # 保持最近50条消息
        if len(self.recent_messages) > 50:
            self.recent_messages = self.recent_messages[-50:]

    # 静态方法
    @staticmethod
    async def send_personal_message(message: dict, consumer: AsyncWebsocketConsumer):
        # 发送个人消息
        await consumer.send(json.dumps(message))

    async def send_other_message(self, message: dict, user: str):
        # 发送个人消息
        for connection in self.active_connections:
            if connection["user"] == user:
                await connection['consumer'].send(message)

    async def broadcast(self, data: dict):
        # 广播消息
        for connection in self.active_connections:
            await connection['consumer'].send(json.dumps(data))

    # 群发
    async def process_message(self, user: str, message: str):
        current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        formatted_message = {"user": user, "message": message, "time": current_time}
        self.add_recent_message(user, message, current_time)
        await self.broadcast(formatted_message)


connect_manager = ConnectionManager()


class Consumers1(AsyncWebsocketConsumer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.username = None

    async def websocket_connect(self, message):
        # 获取 WebSocket 连接的 username 参数
        self.username = self.scope['url_route']['kwargs']['username']
        # 允许客户端创建连接
        await connect_manager.connect(self.username, self)
        # 设置时间并广播消息
        current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        await connect_manager.broadcast({'user': self.username, 'message': '进入聊天', "time": current_time})

    async def websocket_receive(self, message):
        logger.info(message)
        # 获取发送的消息
        # data = json.loads(message['text'])['message']
        # logger.info(connect_manager.recent_messages)
        # 群发
        # await connect_manager.process_message(self.username, data)

    async def websocket_disconnect(self, message):
        # 获取连接用户
        connect_manager.disconnect(self.username, self)
        current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        await connect_manager.broadcast({"user": self.username, "message": "离开", 'time': current_time})
        raise StopConsumer()


socket_list = []


async def find_roles(token):
    token = token.split(" ")[1]
    jwt = FuJwt(SECRET_KEY)
    value = jwt.decode(SECRET_KEY, token)
    user_info = value.payload
    # user_instance = await Users.objects.get(username=user_info['name'])
    # # 查询角色
    # user_roles = await user_instance.role.first()
    user_instance = await sync_to_async(Users.objects.get)(username=user_info['username'])
    # 查询角色
    user_roles = await sync_to_async(lambda: user_instance.role.all().first())()
    return user_roles, user_info


class Consumers(AsyncWebsocketConsumer):
    def __init__(self, *args, **kwargs):
        super().__init__(args, kwargs)
        self.username = None

    async def websocket_connect(self, message):
        self.username = self.scope['url_route']['kwargs']['username']
        await self.accept()
        # 从请求参数中获取username
        user_instance = await sync_to_async(Users.objects.get)(username=self.username)
        # 查询角色
        user_roles = await sync_to_async(lambda: user_instance.role.all().first())()
        if user_roles:
            socket_list.append([self, user_roles.id, self.username])
        else:
            socket_list.append([self, '-1', self.username])

    async def websocket_receive(self, message):
        # logger.info(message['text'])
        d = json.loads(message['text'])
        token = d['data']['token']
        d1 = d['data']
        del d1['token']
        await sync_to_async(MsgHistory.objects.create)(**d1)
        await self.process_send(message)

    async def websocket_disconnect(self, message):
        # 从 socket_list 中删除离开的用户
        for ws in socket_list:
            if ws[0] == self:
                socket_list.remove(ws)
                break
        raise StopConsumer()

    # 用户广播
    async def broadcast_send(self, token, message):
        text = json.dumps(message)
        # sync_to_async(Users.objects.create)(**d1)
        role, user_info = await find_roles(token)
        if not role:
            for ws in socket_list:
                if ws[0] != self and user_info['id'] == 1:
                    await ws[0].send(text)
        # 发送用户的角色和接收用户的角色不能是同一种角色,管理员除外
        else:
            for ws in socket_list:
                if ws[0] != self and ws[1] != role.id:
                    await ws[0].send(text)
                if ws[0] != self and user_info['id'] == 1:
                    await ws[0].send(text)

    # 指定用户发送
    async def process_send(self, message):
        d = json.loads(message['text'])
        receive_user = d['data']['receive_user']
        text = json.dumps(message)
        for ws in socket_list:
            if ws[0] != self and ws[2] == receive_user:
                await ws[0].send(text)
