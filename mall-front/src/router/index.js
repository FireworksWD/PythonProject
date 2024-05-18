import { createRouter, createWebHashHistory } from 'vue-router'

// createRouter 创建路由实例，===> new VueRouter()
// 1. history模式: createWebHistory()   http://xxx/user
// 2. hash模式: createWebHashHistory()  http://xxx/#/user

// vite 的配置 import.meta.env.BASE_URL 是路由的基准地址，默认是 ’/‘
// https://vitejs.dev/guide/build.html#public-base-path

// 如果将来你部署的域名路径是：http://xxx/my-path/user
// vite.config.ts  添加配置  base: my-path，路由这就会加上 my-path 前缀了

const router = createRouter({
  // history: createWebHistory(import.meta.env.BASE_URL),
  history: createWebHashHistory(),
  routes: [
    {
      path: '/',
      name: 'Layout',
      component: () => import('@/views/Layout/Layout.vue'),
      redirect: '/home',
      children: [
        {
          path: '/chat',
          name: 'chat',
          component: () => import('@/views/body/ChatService.vue'),
          meta: {
            keepAlive: true
          }
        },
        {
          path: '/home',
          name: 'home',
          component: () => import('@/views/body/LayoutHome.vue'),
          meta: {
            keepAlive: true
          }
        },
        {
          path: 'address',
          name: 'address',
          component: () => import('@/views/body/LayoutAddress.vue')
        },
        {
          path: 'order',
          name: 'order',
          component: () => import('@/views/body/LayoutOrder.vue')
        },
        {
          path: 'detail/:id',
          name: 'detail',
          component: () => import('@/views/body/LayoutDetail.vue')
        },
        {
          path: 'cart',
          name: 'cart',
          component: () => import('@/views/body/LayoutCart.vue')
        },
        {
          path: 'category/:id',
          name: 'category',
          component: () => import('@/views/body/LayoutCategory.vue')
        }
      ]
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('../views/Login/Login.vue')
    }
  ]
})

// 跳转路由后返回顶部
router.beforeEach((to, from, next) => {
  document.documentElement.scrollTop = 0
  next()
})

export default router
