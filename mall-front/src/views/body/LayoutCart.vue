<script setup>
import { ref, reactive } from 'vue'
import { orderSubmitAPI } from '@/api/order.js'
import { useUserStore } from '@/stores/index.js'
import { shoppingCartDel, shoppingCartList, shoppingPut } from '@/api/cart.js'
import { ElMessage, ElMessageBox } from 'element-plus'
import { base_img_url } from '@/main.js'
import { formatTime } from '../../utils/format.js'
import { Search } from '@element-plus/icons-vue'

//分页
const currentPage = ref(1)
const pageSize = ref(6)
const total = ref(0)
const query = reactive({
  keyword: ''
})
const handleCurrentChange = (val) => {
  currentPage.value = val
  getCartList()
}
// 点击减一按钮
const decrementQuantity = (row) => {
  if (row.product_num > 1) {
    row.product_num--
    handleQuantityChange(row)
  }
}
// 点击加一按钮
const incrementQuantity = (row) => {
  row.product_num++
  handleQuantityChange(row)
}

// 加载购物车数据
const isLoading = ref(false)
const cartList = ref([])
const totalPrice = ref()
const getCartList = async () => {
  isLoading.value = true
  const res = await shoppingCartList(currentPage.value, pageSize.value, query.keyword)
  // console.log(res.data)
  cartList.value = res.data.result.data
  total.value = res.data.result.total
  isLoading.value = false
  totalPrice.value = cartList.value.reduce((pre, next) => pre + next.product_num * next.shop_price, 0)
}
getCartList()

const params = ref({
  userId: '',
  productId: '',
  product_num: '',
  cartId: ''
})
// 总价格处理
// const totalPrice = ref(cartList.value.reduce((pre, next) => pre + next.product_num * next.shop_price, 0))
const handleQuantityChange = async (row) => {
  if (parseInt(row.product_num) <= 0 || row.product_num === '') {
    row.product_num = 1
  }
  // 计算总价
  let price = 0
  cartList.value.forEach((item) => {
    price += item.shop_price * item.product_num
  })
  totalPrice.value = price

  // 调用后端同步数据
  params.value.userId = useUserStore().user.id
  params.value.productId = row.shop_id
  params.value.product_num = row.product_num
  params.value.cartId = row.id
  const res = await shoppingPut(params.value)
  if (res.data.code === 500) {
    ElMessage.warning(res.data.message)
  }
  // 刷新数据
  await getCartList()
}

// 改变订单
const removeItem = async (row) => {
  ElMessageBox.confirm(`你确定要删除${row.shop_name || ''}这条订单?`, '删除', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'success'
  })
    .then(async () => {
      // 调用后端同步数据
      params.value.userId = useUserStore().user.id
      params.value.productId = row.shop_id
      params.value.cartId = row.id
      await shoppingCartDel(params.value)
      // 刷新数据
      await getCartList()
      ElMessage.success('删除成功')
    })
    .catch(() => {
      ElMessage({
        type: 'info',
        message: '取消'
      })
    })
}
// 提交订单
const submitOrder = async () => {
  ElMessageBox.confirm('你确定要下单支付?', '下单', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'success'
  })
    .then(async () => {
      const res = await orderSubmitAPI()
      if (res.data.code === 200) {
        // console.log(res)
        ElMessage.success('下单成功')
      }
      await getCartList()
    })
    .catch(() => {
      ElMessage({
        type: 'info',
        message: '取消下单'
      })
    })
  // const res = await orderSubmitAPI(useUserStore().user.id)
  // console.log(res)
  // ElMessage.success('下单成功')

  // 刷新数据
  await getCartList()
}
//双击粘贴
const copyToClipboard = async (text) => {
  try {
    await navigator.clipboard.writeText(text);
    // 可以添加一些提示信息，例如使用 Element Plus 的 ElMessage
    // this.$message.success('已复制到剪贴板'); // 注意：这里无法直接使用 this，需要通过上下文传递
    ElMessage.success("已复制到剪贴板");
  } catch (err) {
    // console.error("复制失败:", err);
    // 处理复制失败的情况
  }
};
</script>

<template>
  <div class="container" style="margin-top: 20px">
    <el-card class="order-card">
      <el-input v-model="query.keyword" class="search-input" style="width: 400px" placeholder="商品名搜索......">
        <template #prefix>
          <el-icon class="search-icon">
            <Search />
          </el-icon>
        </template>
        <template #suffix>
          <el-button id="searchBtn" @click="getCartList">点击搜索</el-button>
        </template>
      </el-input>
      <!--      <template #header>-->
      <!--        <h3>购物车查看</h3>-->
      <!--      </template>-->
      <el-table :data="cartList" v-loading="isLoading" ref="table">
        <template #empty>
          <div class="empty">
            <span style="font-size: 20px">购物车空空的，快去添加商品吧</span>
            <el-link :underline="false" style="font-size: 20px; margin-left: 40px; margin-bottom: 5px" type="success" @click="$router.replace({ name: 'home' })">回到首页 </el-link>
          </div>
        </template>

        <el-table-column type="index" label="序号" width="auto" />
        <el-table-column prop="img_url" label="商品图片" width="100px">
          <template v-slot="{ row }">
            <el-image
              v-if="base_img_url + row.img_url"
              :src="base_img_url + row.img_url"
              alt="商品封面"
              :preview-src-list="[base_img_url + row.img_url]"
              :preview-teleported="true"
              style="width: auto; height: 40px; border: none; cursor: pointer"
            />
            <span v-else>暂无图片</span>
          </template>
        </el-table-column>
        <el-table-column prop="shop_name" label="商品名称">
          <template #default="{ row }">
            <el-link type="primary" :underline="false" @click="$router.push(`/detail/${row.id}`)">
              <el-popover effect="light" trigger="hover" placement="top" width="auto">
                <template #default>
                  <div>{{ row.shop_name }}</div>
                </template>
                <template #reference>
                  <el-text style="white-space: nowrap" @dblclick="copyToClipboard(row.shop_name)"
                  >{{ row.shop_name }}
                  </el-text>
                </template>
              </el-popover>
            </el-link>
          </template>
        </el-table-column>
        <el-table-column label="单价" width="auto">
          <template #default="scope">
            <span>{{ scope.row.shop_price.toFixed(2) }} 元</span>
          </template>
        </el-table-column>
        <el-table-column label="创建时间" prop="create_time" width="auto">
          {{ formatTime(create_time) }}
        </el-table-column>
        <el-table-column prop="product_num" label="数量">
          <template #default="scope">
            <el-button @click="decrementQuantity(scope.row)">-</el-button>
            <el-input style="width: 50px" v-model="scope.row.product_num" @change="handleQuantityChange(scope.row)"></el-input>
            <el-button @click="incrementQuantity(scope.row)">+</el-button>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template #default="scope">
            <el-button color="#cf4444" plain @click="removeItem(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="footer">
        <span style="margin-right: 1rem"
          >合计（不含运费）：<span style="color: orange; font-size: 1.4rem">￥{{ totalPrice }}</span></span
        >
        <el-button size="large" color="#27ba9b" @click="submitOrder">结算</el-button>
      </div>
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :small="false"
        :disabled="false"
        :background="false"
        layout="prev, pager, next, total"
        :total="total"
        @current-change="handleCurrentChange"
      />
    </el-card>
  </div>
</template>

<style lang="scss" scoped>
.search-input {
  flex-grow: 1; /* 允许输入框占据更多空间 */
  margin-right: 80px; /* 给按钮留出空间 */
}

#searchBtn {
  color: white;
  background-color: #767dff;
  transition: background-color 1s; /* 添加过渡效果 */
}

#searchBtn:hover {
  color: #767dff;
  background-color: white; /* 悬停时的背景颜色 */
}

.cartContainer {
  display: flex;
  margin: 0 auto;
  text-align: center;

  .el-table {
    width: 100%;

    .empty {
      font-size: 18px;
      display: flex;
      align-items: center;
    }
  }

  .footer {
    width: 100%;
    padding: 0 20px;
    backdrop-filter: blur(10px);
    background-color: #e3e2e2;
    height: 60px;
    bottom: 0;
    position: fixed;
    border-top: 1px solid #ccc;
    z-index: 999;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    align-self: flex-start;

    .left {
      display: flex;
      align-items: center;

      .el-checkbox {
        margin-right: 1rem;
      }
    }

    .right {
      height: 60px;
      display: flex;
      flex-direction: row;
      justify-content: center;
      align-items: center;
    }
  }
}

.footer {
  display: flex;
  justify-content: space-between;
  margin-top: 30px;

  .el-button {
    margin-right: 120px;
    width: 100px;
    height: 50px;
  }
}
</style>
