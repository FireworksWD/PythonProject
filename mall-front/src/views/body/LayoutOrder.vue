<script setup>
import { ref, reactive } from 'vue'
import { orderGetListAPI, cancelOrderAPI, payOrderAPI, delOrderAPI, getOrderDetailAPI } from '@/api/order.js'
import { formatTime } from '../../utils/format.js'
import { ElMessage, ElMessageBox } from 'element-plus'
import {base_img_url} from "@/main.js";
//分页
const currentPage = ref(1)
const pageSize = ref(7)
const total = ref(0)
const query = reactive({
  keyword: ''
})
// const showTooltip = (index, show) => {
//   this.currentHoverIndex = show ? index : -1
// }
// const currentHoverIndex = ref(-1)
const handleCurrentChange = (val) => {
  currentPage.value = val
  getOrderList()
}
// 获取订单
const orderList = ref([])
const getOrderList = async () => {
  const res = await orderGetListAPI(currentPage.value, pageSize.value, query.keyword)
  orderList.value = res.data.result.data
  total.value = res.data.result.total
  // console.log(res.data)
}
getOrderList()

// 获取订单详情
const isLoading = ref(false)
const isDetail = ref(false)
const orderDetail = ref([])
const record = ref()
const getOrderDetail = async (row) => {
  record.value = row
  isLoading.value = true
  const res = await getOrderDetailAPI(row.order_number)
  // console.log(res.data.result)
  orderDetail.value = res.data.result
  isLoading.value = false
  isDetail.value = true
}
const cancelOrder = async (data) => {
  ElMessageBox.confirm('你确定要取消订单?', '订单', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'success'
  })
    .then(async () => {
      const res = await cancelOrderAPI(data.id)
      if (res.data.code === 200) {
        ElMessage.success('取消成功,注意查收退款')
      } else {
        ElMessage.warning(res.data.message)
      }
      await getOrderList()
    })
    .catch(() => {
      ElMessage({
        type: 'info',
        message: '取消'
      })
    })
  await getOrderList()
}
// 付款操作
const payHandler = async (orderId) => {
  ElMessageBox.confirm('你确定要付款?', '付款', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'success'
  })
    .then(async () => {
      const res = await payOrderAPI(orderId)
      if (res.data.code === 200) {
        ElMessage.success('付款成功,注意查看商品进度')
        isDetail.value = false
      } else {
        ElMessage.warning(res.data.message)
      }
      await getOrderList()
    })
    .catch(() => {
      ElMessage({
        type: 'info',
        message: '取消'
      })
    })
}
// 删除
const delHandler = async (orderId, order_number) => {
  ElMessageBox.confirm('你确定要删除该条订单?', '订单', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'success'
  })
    .then(async () => {
      const res = await delOrderAPI(orderId, order_number)
      if (res.data.code === 200) {
        ElMessage.success('删除成功')
        isDetail.value = false
      } else {
        ElMessage.warning(res.data.message)
      }
      await getOrderList()
    })
    .catch(() => {
      ElMessage({
        type: 'info',
        message: '取消'
      })
    })
}
//双击粘贴
const copyToClipboard = async (text) => {
  try {
    await navigator.clipboard.writeText(text)
    // 可以添加一些提示信息，例如使用 Element Plus 的 ElMessage
    // this.$message.success('已复制到剪贴板'); // 注意：这里无法直接使用 this，需要通过上下文传递
    ElMessage.success('已复制到剪贴板')
  } catch (err) {
    // console.error("复制失败:", err);
    // 处理复制失败的情况
  }
}
</script>

<template>
  <div class="container" style="margin-top: 20px">
    <el-card class="order-card">
      <el-input v-model="query.keyword" class="search-input" style="width: 400px" placeholder="订单号搜索......">
        <template #prefix>
          <el-icon class="search-icon">
            <Search />
          </el-icon>
        </template>
        <template #suffix>
          <el-button id="searchBtn" @click="getOrderList">点击搜索</el-button>
        </template>
      </el-input>
      <div class="cartContainer">
        <div class="content">
          <el-table :data="orderList" :default-sort="{ prop: 'orderState', order: 'ascending' }" ref="table" empty-text="啥也没有呢">
            <el-table-column prop="order_number" label="订单号" width="180" sortable />
            <!-- <el-table-column label="图片">-->
            <!--   <template #default="scope">-->
            <!--     <el-image :src="scope.row.id" style="width: 80px"></el-image>-->
            <!--   </template>-->
            <!-- </el-table-column>-->
            <el-table-column prop="username" label="用户名" width="80px"></el-table-column>
            <el-table-column label="订单总金额" width="100">
              <template #default="scope">
                <span>{{ scope.row.total_amount.toFixed(2).toString() }}元</span>
              </template>
            </el-table-column>
            <el-table-column label="支付金额" width="100">
              <template #default="scope">
                <span>{{ scope.row.payment_amount.toFixed(2).toString() }}元</span>
              </template>
            </el-table-column>
            <el-table-column prop="payment_status" label="付款状态" sortable>
              <template #default="scope">
                <el-tag type="danger" v-if="scope.row.payment_status === 0">未付款</el-tag>
                <el-tag v-else>已付款</el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="transaction_status" sortable label="交易状态">
              <template #default="scope">
                <el-tag v-if="scope.row.transaction_status === 0" type="danger">等待发货</el-tag>
                <el-tag v-else-if="scope.row.transaction_status === 1" type="success">已提交订单</el-tag>
                <el-tag v-else-if="scope.row.transaction_status === 2" type="warning">已取消订单</el-tag>
                <!-- <span>{{ getOrder(scope.row.orderState) }}</span> -->
              </template>
            </el-table-column>
            <el-table-column prop="recipient_phone" label="收货人号码"></el-table-column>
            <el-table-column prop="recipient_address" label="收货人地址" width="100">
              <template v-slot="scope">
                <el-popover effect="light" trigger="hover" placement="top" width="auto">
                  <template #default>
                    <el-tag>双击复制文本</el-tag>
                    <div>{{ scope.row.recipient_address }}</div>
                  </template>
                  <template #reference>
                    <el-text style="white-space: nowrap" @dblclick="copyToClipboard(scope.row.recipient_address)">{{ scope.row.recipient_address }} </el-text>
                  </template>
                </el-popover>
              </template>
            </el-table-column>
            <el-table-column prop="create_time" label="下单时间">
              {{ formatTime(create_time) }}
            </el-table-column>
            <el-table-column prop="checkout_time" label="结账时间">
              {{ formatTime(checkout_time) }}
            </el-table-column>
            <el-table-column label="操作" align="center">
              <template #default="scope">
                <div class="btnGroup">
                  <el-button link type="primary" @click="getOrderDetail(scope.row)">订单详情</el-button>
                  <el-button link v-if="scope.row.transaction_status === 0" @click="cancelOrder(scope.row)">取消订单 </el-button>
                  <el-button
                    type="danger"
                    link
                    v-if="scope.row.payment_status === 0 && scope.row.transaction_status === 2"
                    @click="delHandler(scope.row.id, scope.row.order_number)"
                    >删除订单</el-button
                  >
                </div>
              </template>
            </el-table-column>
          </el-table>
        </div>
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
    <el-dialog v-model="isDetail" title="订单详情">
      <div class="detailContainer">
        <div class="content">
          <el-table :data="orderDetail" v-loading="isLoading" ref="table" height="350">
          <el-table-column prop="img_url" label="商品图片" >
            <template v-slot="{ row }">
              <el-image
                  v-if="base_img_url + row.img_url"
                  :src="base_img_url + row.img_url"
                  alt="商品封面"
                  :preview-src-list="[base_img_url + row.img_url]"
                  :preview-teleported="true"
                  style="width: auto; height: 80px; border: none; cursor: pointer"
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
            <el-table-column prop="product_num" label="数量">

            </el-table-column>
          </el-table>
          <div style="margin-top: 2rem">
            订单状态：
            <el-steps :active="record.transaction_status - (record.payStatus === 1 ? 0 : 1)" simple finish-status="success" style="margin-top: 1rem">
              <el-step :title="record.transaction_status === 0 ? '订单关闭' : '提交订单'" :status="record.orderStatus === 0 ? 'error' : 'success'"></el-step>
              <el-step :title="record.payment_status === 1 ? '已付款' : '未付款'" :status="record.payStatus === 1 ? 'success' : ''"></el-step>
              <el-step :title="record.transaction_status === 3 ? '已发货' : '等待发货'" :status="record.orderStatus === 3 ? 'success' : ''"></el-step>
              <el-step :title="record.transaction_status === 4 ? '订单完成' : '等待收货'" :status="record.orderStatus === 4 ? 'success' : ''"></el-step>
            </el-steps>
          </div>
        </div>
        <div class="footer">
          <el-button v-if="record.payment_status === 0 && record.transaction_status === 2" @click="payHandler(record.id)" type="primary">付款 </el-button>
        </div>
      </div>
    </el-dialog>
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
  width: 100%;
  margin: 0 auto;

  .content {
    .el-table {
      .el-button {
        margin: 0 0 10px;
      }

      .el-button:last-child {
        margin-bottom: 0;
      }

      .btnGroup {
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
      }
    }

    .detailContainer {
      display: flex;
      flex-direction: column;
      padding: 1rem;

      .content {
        div {
          margin-bottom: 0.4rem;
          padding: 40px 0px;

          span {
            color: #424242;
            font-weight: bold;
          }
        }
      }

      .footer {
        margin-top: 2rem;
        text-align: right;
      }
    }
  }
}

.detailContainer {
  .content {
    div {
      padding: 8px 0;
      font-size: 16px;
    }
  }
}
</style>
