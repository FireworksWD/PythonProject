import {defHttp} from '/@/utils/http/axios';

//获取订单
export const OrderListAPI = (currentPage: any, pageSize: any, keyword: any, username: any) => {
  return defHttp.get({
    url: '/api/mall/order/v1/ad/list',
    params: {currentPage, pageSize, keyword, username}
  });
}
//修改
export const UpdateOrderAPI = (id: any) => {
  return defHttp.get({
    url: '/api/mall/order/v1/ad/update?id=' + id,
  });
}
//取消操作
export const CancelOrderAPI = (id: any) => {
  return defHttp.get({
    url: '/api/mall/order/v1/ad/cancel?id=' + id,
  });
}
//详情
export const GetOrderDetailAPI = (order_number: any, user_id: any) => {
  return defHttp.get({
    url: '/api/mall/order/v1/detail?order_number=' + order_number + '&user_id=' + user_id,
  });
}
