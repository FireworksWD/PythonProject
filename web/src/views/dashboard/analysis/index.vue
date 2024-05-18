<template>
  <div ref='vantaRef' class="vantaRefs">
  </div>
</template>

<script>
import * as THREE from 'three'
import BIRDS from 'vanta/src/vanta.globe'

export default {
  mounted() {
    this.vantaEffect = BIRDS({
      el: this.$refs.vantaRef,
      THREE: THREE
    })
  },
  beforeDestroy() {
    if (this.vantaEffect) {
      this.vantaEffect.destroy()
    }
  }
}
</script>
<style lang="less" scoped>
.vantaRefs {
  height: 100%;
  width: 100%;
}

</style>
