import { defineStore } from 'pinia'
import { ref } from 'vue'
import { userGetInfoAPI } from '@/api/user.js'

export const useUserStore = defineStore(
  'User',
  () => {
    // 定义管理用户数据的state和操作数据的action

    const token = ref('')
    const setToken = (newToken) => {
      token.value = newToken
      localStorage.setItem('token', newToken)
    }
    const removeToken = () => {
      token.value = ''
      localStorage.removeItem('token')
    }

    const user = ref({})
    const getUserInfo = async () => {
      const res = await userGetInfoAPI()
      user.value = res.data.result
    }
    const setUserInfo = (userInfo) => {
      user.value = userInfo
    }
    return {
      token,
      setToken,
      removeToken,
      user,
      getUserInfo,
      setUserInfo
    }
  },
  {
    // 数据持久化存储
    // 原理：设置state时会把数据自动同步给localStorage，获取数据时优先从localStorage获取
    persist: true
  }
)
