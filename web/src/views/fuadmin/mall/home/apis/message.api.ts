import {defHttp} from '/@/utils/http/axios';

//获取用户数据
export const getMsgUserListAPI = () => {
  return defHttp.get({
    url: '/api/mall/msg/v1/usr',
  });
};
//获取聊天记录客服
export const getHistoryMsgUserListAPI = (username: any) => {
  return defHttp.get({
    url: '/api/mall/msg/v1/cu/list?username=' + username,
  });
};
