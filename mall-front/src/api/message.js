import httpInstance from '@/utils/request.js'

//获取消息记录
export const getMsgUserAPI = (customer_username) => {
    return httpInstance({
        url: '/mall/msg/v1/cn/list',
        method: 'GET',
        params: {customer_username}
    })
}
//获取客服列表
export const getCustomerAPI = () => {
    return httpInstance({
        url: '/mall/msg/v1/customer',
        method: 'GET',
    })
}
