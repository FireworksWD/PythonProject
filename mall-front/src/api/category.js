import httpInstance from '@/utils/request.js'

// 条件查询分类数据
export const categoryListAPI = (keyWord) => {
  return httpInstance({
    url: '/mall/v1/category_list',
    method: 'GET',
    params: { keyWord }
  })
}
