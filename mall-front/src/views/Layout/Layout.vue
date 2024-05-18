<script setup>
import LayoutHeader from '@/views/Layout/components/LayoutHeader.vue'
import LayoutNav from '@/views/Layout/components/LayoutNav.vue'
import LayoutFooter from '@/views/Layout/components/LayoutFooter.vue'
// import {ref, watch} from 'vue'
import {useRoute} from 'vue-router'

// const showFooter = ref(true)
//
// watch(() => {
//   // 根据路由的变化来决定是否显示 Footer
//   showFooter.value = useRoute().path !== '/chat'
// })
</script>

<template>
  <LayoutHeader/>
  <LayoutNav/>
  <RouterView />
  <LayoutFooter/>
</template>

<style scoped></style>
