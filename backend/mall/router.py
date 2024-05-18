from datetime import datetime

from ninja import Router
from ninja.security import HttpBearer

from fuadmin.settings import SECRET_KEY
from mall.apis.product import router as product_router
from mall.apis.category import router as category_router
from mall.apis.cart import router as cart_router
from mall.apis.address import router as address_router
from mall.apis.order import router as order_router
from mall.apis.message import router as message_router
from mall.apis.echarts import router as echarts_router
from utils.fu_jwt import FuJwt


class MallAuth(HttpBearer):
    def authenticate(self, request, token):
        jwt = FuJwt(SECRET_KEY)
        value = jwt.decode(SECRET_KEY, token)
        time_now = int(datetime.now().timestamp())
        # 判断token是否过期
        if value.valid_to >= time_now:
            return token
        else:
            raise TimeoutError(401, 'token时间过期')


mall_router = Router(auth=MallAuth)
mall_router.add_router('/', product_router, tags=["mall"]),
mall_router.add_router('/', category_router, tags=['category'])
mall_router.add_router('/', cart_router, tags=['cart'])
mall_router.add_router('/', address_router, tags=['address'])
mall_router.add_router('/', order_router, tags=['order'])
mall_router.add_router('/', message_router, tags=['message'])
mall_router.add_router('/', echarts_router, tags=['echarts'])
