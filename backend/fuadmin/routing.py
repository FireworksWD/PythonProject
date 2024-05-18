from mall.ChatService import Consumers
from django.urls import path

websocket_urlpatterns = [
    path('ws/<str:username>', Consumers.as_asgi()),
    # path('ws', Consumers.as_asgi()),
]
