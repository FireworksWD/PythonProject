import time

from django.db import models
from django.utils import timezone


# Create your models here.
class Product(models.Model):
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='价格')
    number = models.IntegerField(verbose_name='数量')
    user_id = models.IntegerField(verbose_name='用户id')
    name = models.CharField(max_length=128, verbose_name='商品名称')
    description = models.CharField(max_length=256, verbose_name='描述')
    img_url = models.ImageField(upload_to='images/%Y/%m/%d', null=True, blank=True, verbose_name='商品图片',
                                default='images/default.jpg')
    # 创建时间字段
    create_time = models.DateTimeField(default=timezone.now, null=True)
    categoryName = models.CharField(max_length=50)

    class Meta:
        db_table = 'mall_product'
        verbose_name = '商品表'
        verbose_name_plural = verbose_name


class Cart(models.Model):
    user_id = models.IntegerField()
    shop_id = models.IntegerField()
    status = models.CharField(max_length=32, verbose_name='状态')
    shop_price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='商品价格')
    shop_name = models.CharField(max_length=128, unique=True, verbose_name='商品名称')
    username = models.CharField(max_length=150, verbose_name='用户名称')
    create_time = models.DateTimeField(default=timezone.now, verbose_name='创建时间')
    product_num = models.IntegerField(verbose_name='总数')
    img_url = models.ImageField(upload_to='images/%Y/%m/%d', null=True, blank=True, verbose_name='商品图片',
                                default='images/default.jpg')

    class Meta:
        db_table = 'mall_cart'
        verbose_name = '购物车'
        verbose_name_plural = verbose_name
        ordering = ('-create_time',)


# 订单表
class Order(models.Model):
    # 订单号，默认使用时间戳表示
    order_number = models.CharField(max_length=20, default=str(int(time.time())))
    # 用户名
    username = models.CharField(max_length=100)
    # 订单总金额
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    # 支付金额
    payment_amount = models.DecimalField(max_digits=10, decimal_places=2)
    # 付款状态，默认为1 为已付款
    payment_status = models.IntegerField(default=1)
    # 交易状态 0等待发货 1已提交订单 2已取消订单
    transaction_status = models.IntegerField(default=0)
    # 收货人号码
    recipient_phone = models.CharField(max_length=15, blank=True, null=True)
    # 收货人地址
    recipient_address = models.TextField(blank=True, null=True)
    # 下单时间，默认为创建的时间
    create_time = models.DateTimeField(default=timezone.now)
    # 结账时间，可以为空
    checkout_time = models.DateTimeField(blank=True, null=True)
    # 当前用户
    user_id = models.IntegerField()

    class Meta:
        db_table = 'mall_order'
        verbose_name = '订单表'
        verbose_name_plural = verbose_name
        ordering = ('-create_time',)


class OrderDetail(models.Model):
    img_url = models.ImageField(upload_to='images/%Y/%m/%d', null=True, blank=True, verbose_name='商品图片',
                                default='images/default.jpg')
    product_num = models.IntegerField(verbose_name='总数')
    shop_price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='商品价格')
    shop_name = models.CharField(max_length=128, verbose_name='商品名称')
    user_id = models.IntegerField()
    shop_id = models.IntegerField()
    order_number = models.CharField(max_length=20)
    is_delete = models.IntegerField(default=0, verbose_name='是否删除')
    create_time = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = 'mall_order_detail'
        verbose_name = '订单详情表'
        verbose_name_plural = verbose_name
        ordering = ('-create_time',)


class Address(models.Model):
    # 收货人
    username = models.CharField(max_length=100, blank=True, null=True)
    # 联系方式
    contact_number = models.CharField(max_length=15, blank=True, null=True)
    # 收货地址
    delivery_address = models.CharField(max_length=255, blank=True, null=True)
    # 详细地址
    detailed_address = models.TextField(blank=True, null=True)
    # 默认地址
    is_default = models.IntegerField(default=0)
    create_time = models.DateTimeField(default=timezone.now)
    user_id = models.IntegerField()

    class Meta:
        db_table = 'mall_address'
        verbose_name = '地址'
        verbose_name_plural = verbose_name
        ordering = ('-create_time',)


class CateGory(models.Model):
    # 类型名称，唯一
    categoryName = models.CharField(max_length=50, unique=True)
    create_time = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = 'mall_category'
        verbose_name = '地址'
        verbose_name_plural = verbose_name
        ordering = ('-create_time',)


class MsgHistory(models.Model):
    uid = models.IntegerField(verbose_name='发消息的用户id')
    username = models.CharField(max_length=128, verbose_name='发消息的用户')
    dateTime = models.CharField(max_length=256, verbose_name='时间')
    text = models.TextField(verbose_name='文本消息')
    # 0未查看
    read_state = models.IntegerField(default=0, verbose_name='是否查看')
    receive_user = models.CharField(max_length=128, verbose_name='接收用户名')
    img = models.CharField(max_length=256, verbose_name='用户图片')

    class Meta:
        db_table = 'mall_msg'
        verbose_name = '聊天记录'
        verbose_name_plural = verbose_name
        ordering = ('-dateTime',)


# class UserHitProduct(models.Model):
#     uid = models.IntegerField(verbose_name='用户id')
#     pid = models.IntegerField(verbose_name='商品id')
#     username = models.CharField(max_length=128, verbose_name='用户')
#     product = models.CharField(max_length=128, verbose_name='商品名称')
#     categoryName = models.CharField(max_length=128, verbose_name='类型')
#     hit = models.IntegerField(verbose_name='用户点击这个商品的次数')
#     create_time = models.DateTimeField(default=timezone.now)
#
#     class Meta:
#         db_table = 'mall_user_product'
#         verbose_name = '用户行为表'
#         verbose_name_plural = verbose_name
#         ordering = ('-create_time',)0.


class HotProduct(models.Model):
    pid = models.IntegerField(verbose_name='商品id')
    product = models.CharField(max_length=128, verbose_name='商品名称')
    hit = models.IntegerField(verbose_name='商品的点击次数')
    create_time = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = 'mall_hit_product'
        verbose_name = '商品点击表'
        verbose_name_plural = verbose_name
        ordering = ('-create_time',)


class KeywordHot(models.Model):
    keyword = models.CharField(max_length=128, verbose_name='关键字')
    num = models.IntegerField(verbose_name='关键字')
    create_time = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = 'mall_keyword'
        verbose_name = '关键字'
        verbose_name_plural = verbose_name
        ordering = ('-create_time',)
