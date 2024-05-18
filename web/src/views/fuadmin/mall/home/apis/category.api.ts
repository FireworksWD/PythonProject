import {defHttp} from '/@/utils/http/axios';

//获取商品类型
export const CategoryListAPI = (currentPage: any, pageSize: any, keyword: any) => {
    return defHttp.get({
        url: '/api/mall/v1/category_page',
        params: {currentPage, pageSize, keyword}
    });
}
//删除
export const DelCategoryAPI = (id:any) => {
    return defHttp.delete({
        url: '/api/mall/v1/category?id='+id,
    });
}
//增加
export const AddCategoryAPI = (data:any) => {
    return defHttp.post({
        url: '/api/mall/v1/category/add',
        data
    });
}
