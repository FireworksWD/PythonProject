import httpInstance from '@/utils/request.js'

// 提交订单, 登录了就不传
export const orderSubmitAPI = () => {
    return httpInstance({
        url: '/mall/order/v1/submit',
        method: 'GET'
    })
}

// 根据用户Id进行订单查询，返回订单列表数据  userId可传可不传 返回List
export const orderGetListAPI = (currentPage, pageSize, keyword) => {
    return httpInstance({
        url: '/mall/order/v1/list',
        method: 'GET',
        params: {currentPage, pageSize, keyword}
    })
}
// 取消订单
export const cancelOrderAPI = (orderId) => {
    return httpInstance({
        url: '/mall/order/v1/cancel',
        method: 'get',
        params: {orderId}
    })
}
// 付款
export const payOrderAPI = (orderId) => {
    return httpInstance({
        url: '/mall/order/v1/pay',
        method: 'get',
        params: {orderId}
    })
}
//删除
export const delOrderAPI = (orderId, order_number) => {
    return httpInstance({
        url: '/mall/order/v1/del',
        method: 'get',
        params: {orderId, order_number}
    })
}
//详情
export const getOrderDetailAPI=(order_number)=>{
    return httpInstance({
        url: '/mall/order/v1/detail',
        method: 'get',
        params: {order_number}
    })
}
