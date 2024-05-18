<template>
  <div ref="loginPageRef" class="body">
    自定义页面内容
  </div>
</template>
<script lang="ts" setup>
import * as THREE from 'three'
import NET from 'vanta/dist/vanta.ripple.min'
import {ref,onMounted,onBeforeUnmount} from "vue";

let vantaEffect = null
const loginPageRef = ref()
onMounted(() => {
  if (loginPageRef.value) {
    vantaEffect = NET({
      el: loginPageRef.value,
      THREE,
      mouseControls: true,
      touchControls: true,
      gyroControls: false,
      minHeight: 200.0,
      minWidth: 200.0,
      scale: 1.0,
      scaleMobile: 1.0,
    })
  }

  console.log(vantaEffect)
})

onBeforeUnmount(() => {
  if (vantaEffect) vantaEffect.destroy()
})
</script>

<style lang='less' scoped>

.body{
  width: 100vw;
  height: 100vh;
}
</style>
