import {defHttp} from '/@/utils/http/axios';
// keyword
export const GetKeywordAPI = () => {
  return defHttp.get({
    url: '/api/mall/echarts/v1/keyword'
  })
}
// 库存
export const GetProductAPI = () => {
  return defHttp.get({
    url: '/api/mall/echarts/v1/product'
  })
}
//热门
export const GetHotProductAPI = () => {
  return defHttp.get({
    url: '/api/mall/echarts/v1/hot_product'
  })
}

//最近一周热门地区的销售额
export const GetAddressProductAPI = () => {
  return defHttp.get({
    url: '/api/mall/echarts/v1/address/product'
  })
}
