import httpInstance from '@/utils/request.js'

// 根据id查询
export const productGetAPI = (product_id) => {
  return httpInstance({
    url: '/mall/product/v1',
    method: 'GET',
    params: { product_id }
  })
}

// 条件分页查询
export const productPageAPI = ({ currentPage, pageSize, keyword }) => {
  return httpInstance({
    url: '/mall/product/v1/list',
    method: 'GET',
    params: { currentPage, pageSize, keyword }
  })
}

// 条件种类分页查询
export const PageByCategoryIdAPI = ({ currentPage, pageSize, categoryId }) => {
  return httpInstance({
    url: `/mall/product_list?currentPage=${currentPage}&pageSize=${pageSize}&categoryid=${categoryId}`,
    method: 'GET'
  })
}
//轮播图
export const imgRandomAPI = () => {
  return httpInstance({
    url: `/mall/product/v1/random`,
    method: 'GET'
  })
}
