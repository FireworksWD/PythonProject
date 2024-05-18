<script setup>
import {useUserStore} from '@/stores/index.js'
import avatar from '@/assets/image/avatar.jpg'
import router from '@/router'
import {base_img_url} from "@/main.js";
import {ElMessage} from "element-plus";
import {reactive, ref} from "vue";
import {userGetInfoAPI} from '@/api/user.js'
const userStore = useUserStore()

const confirm = () => {
  // 1 清除用户信息
  userStore.removeToken()
  userStore.setUserInfo({})

  // 2 返回到登录页
  // router.replace({path: '/login'})
  setTimeout(() => {
    router.push('/login')
  }, 500)
}
const uploadSuccess = async (res, upload) => {
  console.log(res)
  if (res.result.code === 200) {
    ElMessage({
      type: 'success',
      message: '上传成功'
    })
    console.log(res)
    userStore.user.avatars = res.result.img_url
    dialogTableVisible.value = false
  } else {
    ElMessage({
      type: 'warning',
      message: 'error!!!'
    })
  }
}
const uploadError = () => {
  ElMessage({
    type: 'error',
    message: '上传失败'
  })
}
const dialogTableVisible = ref(false)
const updateAvatar = () => {
  dialogTableVisible.value = true
}
</script>

<template>
  <nav class="app-topNav">
    <div class="container">
      <ul>
        <!-- 多模板渲染 区分登录状态和非登录状态 userStore.userInfo.token-->
        <template v-if="userStore.token">
          <!--          <li>-->
          <!--            <a href="javascript:;" @click="router.push('/admin')"-->
          <!--              ><el-icon><ChromeFilled /></el-icon>进入后台</a-->
          <!--            >-->
          <!--          </li>-->
          <li>
            <a href=""><i class="iconfont icon-user"></i> {{ userStore.user.username }} </a>
          </li>
          <li>
            <el-popconfirm @confirm="confirm" title="确认退出吗？" confirm-button-text="确认" cancel-button-text="取消">
              <template #reference>
                <a href="javascript:;">退出登录</a>
              </template>
            </el-popconfirm>
          </li>
          <li><a href="javascript:;" @click="router.push('/order')">我的订单</a></li>
          <li><a href="javascript:;" @click="router.push('/address')">地址管理</a></li>
          <li style="margin-left: 5px">
            <div @click="updateAvatar">
              <el-avatar :src="userStore.user.avatars || avatar"></el-avatar>
            </div>
          </li>
        </template>
        <template v-else>
          <li><a href="javascript:;" @click="$router.push('/login')">请先登录</a></li>
          <!--                    <router-link to="/login">-->
          <!--                      <a href="javascript:;">退出登录</a>-->
          <!--                    </router-link>-->
          <li><a href="javascript:;">帮助中心</a></li>
          <li><a href="javascript:;">关于我们</a></li>
        </template>
      </ul>
    </div>
  </nav>

  <el-dialog v-model="dialogTableVisible" title="头像上传(拖拽或者点击)" width="500">
    <el-card shadow="always" class="product-detail-card">
      <el-upload
          :limit="1"
          class="upload-demo"
          drag
          :action="`${base_img_url}/api/mall/user/v1/img`"
          :headers="{'Authorization':`${userStore.token}`}"
          multiple
          accept=".jpg, .png"
          :on-success="uploadSuccess"
          :on-error="uploadError"
      >
        <el-image w-full
                  :src="userStore.user.avatars"/>
        <template #tip>
          <div class="el-upload__tip">
            jpg/png files
          </div>
        </template>
      </el-upload>
    </el-card>
  </el-dialog>
</template>

<style scoped lang="scss">
.app-topNav {
  background: #544e4e;
  min-width: 1240px;

  ul {
    display: flex;
    height: 43px;
    justify-content: flex-end;
    align-items: center;
  }

  li {
    a {
      padding: 0 15px;
      color: #cdcdcd;
      line-height: 1;
      display: inline-block;
    }

    i {
      font-size: 14px;
      margin-right: 2px;
    }

    &:hover a {
      color: $xtxColor;
    }

    ~ li {
      a {
        border-left: 2px solid #666;
      }
    }
  }
}
</style>
