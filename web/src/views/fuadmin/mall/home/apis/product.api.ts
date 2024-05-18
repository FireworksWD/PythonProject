import {defHttp} from '/@/utils/http/axios';

//获取商品数据
export const getProductListAPI = (page: any, pageSize: any, keyword: any) => {
    return defHttp.get({
        url: '/api/mall/product_list_id',
        params: {page, pageSize, keyword}
    });
};
//获取商品类型
export const getCategoryListAPI = () => {
    return defHttp.get({
        url: '/api/mall/v1/category_list',
    });
}
//删除商品
export const deleteProductAPI = (product_id: any) => {
    return defHttp.delete({
        url: `/api/mall/product/v1/del?product_id=${product_id}`,
    });
}
//商品详情
export const detailProductAPI = (product_id: any) => {
    return defHttp.get({
        url: `/api/mall/product/v1`,
        params:{product_id}
    });
}
// 新增或者是修改
export const submitAPI = (isCreated, data,product_id) => {
    if (isCreated === false) {
        return defHttp.put({
            url: `/api/mall/product/v1/update`,
            params: {product_id},
            data
        });
    }
    else {
        return defHttp.post({
            url: `/api/mall/product/v1/add`,
            data
        });
    }
}
