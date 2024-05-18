import httpInstance from '@/utils/request.js'

// 添加购物车商品  data={ bookId, bookCount }
export const shoppingCartAdd = (data) => {
  return httpInstance({
    url: '/mall/cart/v1/add',
    method: 'POST',
    data
  })
}

// 修改购物车商品 登录后才能查看  data={ userId bookID, bookCount }
export const shoppingCartDel = (data) => {
  return httpInstance({
    url: `/mall/cart/v1/delete?productId=${data.productId}&cartId=${data.cartId}`,
    method: 'delete'
  })
}

// 查看购物车商品pn
export const shoppingCartList = (currentPage, pageSize, keyword) => {
  return httpInstance({
    url: '/mall/cart/v1/list',
    method: 'GET',
    params: { currentPage, pageSize, keyword }
  })
}

// 清空购物车   清空当前登录用户的购物车
export const shoppingCartClean = () => {
  return httpInstance({
    url: '/cart/clean',
    method: 'DELETE'
  })
}

export const shoppingPut = (data) => {
  return httpInstance({
    url: `/mall/cart/v1/change?productId=${data.productId}&cartId=${data.cartId}&num=${data.product_num}`,
    method: 'PUT'
  })
}
