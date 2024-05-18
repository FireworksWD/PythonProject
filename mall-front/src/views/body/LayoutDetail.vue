<script setup>
import { productGetAPI } from '@/api/product.js'
import { useRoute } from 'vue-router'
import { ref } from 'vue'
import { shoppingCartAdd } from '@/api/cart.js'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/stores/index.js'
import {base_img_url} from "@/main.js";

const route = useRoute()
const product = ref()
const getproductDetail = async () => {
  const res = await productGetAPI(route.params.id)
  product.value = res.data.result
}
getproductDetail()

// 添加购物车功能
const data = ref({
  userId: '',
  productId: '',
  productCount: 0
})
const onAddCart = async () => {
  data.value.userId = useUserStore().user.id
  data.value.productId = route.params.id
  await shoppingCartAdd(data.value)
  ElMessage.success('添加成功')
  product.value.number = product.value.number - data.value.productCount
  await getproductDetail()
}

// watch(() => data.value.productCount, (value, oldValue) => {
//
// })
// const person = reactive({name: '小松菜奈'})
// watch(
//   () => person.name,
//   (value, oldValue) => {
//     console.log(value, oldValue)
//   }, {immediate:true}
// )
// person.name = '有村架纯'
//
// // 直接侦听ref
// const ageRef = ref(16)
// const stopAgeWatcher = watch(ageRef, (value, oldValue) => {
//   console.log(value, oldValue)
//   if (value > 18) {
//     stopAgeWatcher() // 当ageRef大于18，停止侦听
//   }
// })
</script>

<template>
  <div class="container detail">
    <div class="img" style="margin-left: 20px">
      <!--      <img :src="product.image" alt="" />-->
      <el-image style="width: 300px; height: 300px" :src="base_img_url + product.img_url" fit="cover" />
    </div>
    <div class="des">
      <el-descriptions title="商品详情" :column="1" size="large" border>
        <el-descriptions-item label="商品名称" min-width="90px">{{ product.name }}</el-descriptions-item>
<!--        <el-descriptions-item label="作者">{{ product.author }}</el-descriptions-item>-->
        <el-descriptions-item label="商品分类">{{ product.categoryName }}</el-descriptions-item>
        <el-descriptions-item label="商品价格">￥ {{ product.price }}</el-descriptions-item>
        <el-descriptions-item label="商品描述">{{ product.description }}</el-descriptions-item>
      </el-descriptions>
      <div class="check">
        <el-text class="mx-1" type="success">当前库存{{ product.number }}</el-text>
        <el-input-number v-model="data.productCount" :min="1" :max="product.number" style="margin-left: 20px" />
        <el-button size="large" color="#626AEF" @click="onAddCart" style="margin-left: 40px; margin-right: 20px">加入购物车</el-button>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.check {
  padding-top: 100px;
  height: 150px;
  text-align: right;
}

.el-image {
  margin-top: 20%;
  margin-left: 30%;
}

.detail {
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  box-shadow: 0 2px 10px lightgray;
  background-color: #fff;
}

.des {
  width: 60%;
  height: 100%;
  background-color: #fff;
  padding: 20px 20px;
}

.el-descriptions {
  margin-top: 20px;
}
</style>
