<script setup>
import {ref, reactive} from 'vue'
import {useRouter} from 'vue-router'
import {categoryListAPI} from '@/api/category.js'
const categoryList = ref([])
const router = useRouter()
const getCategoryList = async () => {
  const res = await categoryListAPI()
  categoryList.value = res.data.result
}
getCategoryList()

const jumpTo = (path) => {
  router.push(path)
  // router.push({ path: path })
  // this.$router.push({ path: path })
}
</script>

<template>
  <div class="navigation" style="background-color: #fff">
    <div class="container">
      <el-menu class="" mode="horizontal" :default-active="$route.path" :ellipsis="false" unique-opened router
               select="pageChangeHandler">
        <!-- 主菜单 -->
        <el-menu-item class="logo" disabled>
          <span>纷飞家电</span>
        </el-menu-item>
        <el-menu-item index="/home" @click="$router.push('/home')">首页</el-menu-item>
        <el-sub-menu index="/category">
          <template #title>家电类别</template>
          <el-menu-item v-for="item in categoryList" :key="item.id" :index="`/category/${item.id}`">
            {{ item.categoryName }}
          </el-menu-item>
        </el-sub-menu>
        <el-menu-item index="/cart" @click="jumpTo('/cart')">购物车</el-menu-item>
        <el-menu-item index="/order" @click="$router.push('/order')">我的订单</el-menu-item>
        <el-menu-item index="/address" @click="jumpTo('/address')">收货地址</el-menu-item>
        <el-menu-item index="/address" @click="jumpTo('/chat')">客服中心</el-menu-item>
        <!-- 搜索框 -->
        <div style="flex-grow: 1"></div>
<!--        <div class="searchInput">-->
<!--          <el-input placeholder="搜索" v-model="query.keyword" :trigger-on-focus="true">-->
<!--            <template #suffix>-->
<!--              <el-button id="searchBtn" @click="onHandlerClick">点击搜索</el-button>-->
<!--            </template>-->
<!--          </el-input>-->
<!--        </div>-->
        <!--      &lt;!&ndash; 用户菜单 &ndash;&gt;-->
        <!--      <div style="flex-grow: 1"></div>-->
        <!--      &lt;!&ndash; <el-menu-item index="/User/register" v-if="!isLogin">注册</el-menu-item> &ndash;&gt;-->
        <!--      <el-menu-item index="/User/login" v-if="!isLogin">登录 / 注册</el-menu-item>-->
        <!--      <el-dropdown v-else class="loginUser">-->
        <!--        <div>-->
        <!--          您好，<span style="color: #1d2731; margin-right: 0.4rem; font-weight: bold">{{ username }}</span>-->
        <!--          <el-icon><arrow-down /></el-icon>-->
        <!--        </div>-->
        <!--        <template #dropdown>-->
        <!--          <el-dropdown-menu>-->
        <!--            <el-dropdown-item v-for="item in userMenu" @click="userMenuHandler(item)" :key="item">-->
        <!--              {{ item.title }}-->
        <!--            </el-dropdown-item>-->
        <!--            <el-dropdown-item @click="logoutHandler">注销</el-dropdown-item>-->
        <!--          </el-dropdown-menu>-->
        <!--        </template>-->
        <!--      </el-dropdown>-->
      </el-menu>
    </div>
  </div>
</template>

<style scoped lang="scss">
.navigation {
  min-width: 100%;
  //--el-menu-bg-color: #90caf9;
  --el-menu-active-color: $xtxColor;
  box-shadow: 0 2px 10px lightgray;

  .logo {
    cursor: default;

    span {
      font-size: 1.2rem;
      font-weight: bold;
    }
  }

  .el-menu-item.is-disabled {
    opacity: 1;
  }

  .user {
    display: flex;
    flex-direction: row;
  }

  .loginUser {
    position: relative;
    align-items: center;
    cursor: default;
    margin-right: 0.5rem;
  }

  .searchInput {
    position: relative;
    width: 300px;
    margin-top: 14px;
    height: 50%;
    align-items: center;
  }
}
</style>
