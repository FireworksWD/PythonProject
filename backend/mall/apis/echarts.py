from collections import Counter
from datetime import timedelta
from django.utils import timezone

from django.db.models import Count, Sum, Func, Value, CharField
from ninja import Router, Schema, Field, Query
from ninja.pagination import paginate
from typing import List, Optional

from mall.models import Cart, Product, HotProduct, KeywordHot, Order
from django.db.models.functions import TruncDate

from utils.fu_ninja import MyPagination
from ninja.orm import create_schema

router = Router()
out = create_schema(Product)


class QuerySchema(Schema):
    search: Optional[str] = Field(None, q=['name__icontains', 'description__icontains'], expression_connector='OR')


# ninja分页测试?limit=10&offset=0
@router.get("/get/all", auth=None, response=List[out])
@paginate()
def get_all(request):
    qs = Product.objects.all()
    return qs


# 前十的热门商品
@router.get('/echarts/v1/hot_product',auth=None)
def get_hot_product_list(request):
    qs = HotProduct.objects.order_by('-hit').all()[:10]
    res = []
    for item in qs:
        res.append({'name': item.product, 'value': item.hit})
    return res


# 关键字排名
@router.get('/echarts/v1/keyword',auth=None)
def get_keyword_list(request):
    qs = KeywordHot.objects.order_by('-num').all()[:10]
    res = []
    for item in qs:
        res.append({'name': item.keyword, 'value': item.num})
    return res


# 查询商品库存不足的
@router.get('/echarts/v1/product',auth=None)
def get_product(request):
    qs = Product.objects.filter(number__lte=100).all()[:50]
    res = []
    for item in qs:
        res.append([item.name, item.categoryName, item.number])
    return res


# 不同地区的销售商品分析
@router.get('/echarts/v1/address/product',auth=None)
def get_address_product(request):
    # 统计地区
    data = Order.objects.values_list('recipient_address', flat=True)
    split_address = [item.split('/')[0] for item in data]

    # # 将切割后的数据进行扁平化处理
    # flat_data = [item for sublist in split_data for item in sublist if item == sublist[0]]

    # 使用Counter统计每个元素出现的次数
    counts = Counter(split_address)
    sorted_counts = sorted(counts.items(), key=lambda x: x[1], reverse=True)
    # print(counts)
    # 打印排序后的结果
    # for item, count in sorted_counts:
    #     print(item, count)
    # 计算最近7天的日期范围
    end_date = timezone.now().date() - timedelta(days=1)  # 当前日期的前一天
    start_date = end_date - timedelta(days=6)  # 最近7天的起始日期
    # 生成日期序列
    date_res = []
    current_date = start_date
    while current_date <= end_date:
        date_res.append(str(current_date))
        current_date += timedelta(days=1)
    value_res = []
    address_res = []
    # 每天的销售额的排名
    for address, count in sorted_counts:
        address_res.append(address)
        res = Order.objects.filter(recipient_address__icontains=address,
                                   create_time__date__range=[start_date, end_date]).annotate(
            date=TruncDate('create_time')).values(
            'date', 'recipient_address').annotate(
            total_amount=Sum('payment_amount')).order_by(
            '-date')
        temp_list = [0.0] * 7
        for entry in res:
            if str(entry['date']) in date_res:
                index = date_res.index(str(entry['date']))
                temp_list[index] = float(entry['total_amount'])
        value_res.append(temp_list)
        # print(entry['date'], entry['total_amount'], entry['recipient_address'].split('/')[0])
    result = []
    result.extend([address_res, date_res, value_res])
    return result
