from datetime import datetime
from ninja import Schema
from typing import List


# 数据库表的映射
class ProductSchema(Schema):
    id: int = None
    price: float = None
    number: int = None
    user_id: int = None
    name: str = None
    description: str = None
    img_url: str = None
    create_time: datetime = None
    categoryName: str = None


class OrderSchema(Schema):
    id: int = None
    user_id: int = None
    shop_id: int = None
    status: str = None
    shop_price: float = None
    order_balance: float = None
    shop_name: str = None
    username: str = None
    create_time: datetime = None
    img_url: str = None
    product_num: int = None

    class Config:
        json_encoders = {
            datetime: lambda v: v.strftime("%Y-%m-%d %H:%M:%S")
        }


# 带分页参数的返回类型
class PageProductSchemaOut(Schema):
    page: int = None
    pageSize: int = None
    total: int = None
    data: List[ProductSchema]


class PageCartSchemaOut(Schema):
    page: int = None
    pageSize: int = None
    total: int = None
    data: List[OrderSchema]


# 修改商品结构
class ChangeProductSchema(Schema):
    price: float = None
    number: int = None
    description: str = None
    categoryName: str = None
    name: str = None
    img_url: str = None


# 增加商品所必须的字段
class ProductSchemaIn(Schema):
    price: float
    number: int
    user_id: int
    name: str
    description: str
