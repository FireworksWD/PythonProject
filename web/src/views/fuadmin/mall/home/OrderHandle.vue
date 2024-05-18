<script setup>
import {RefreshLeft, Search} from "@element-plus/icons-vue";
import {reactive, ref, watch} from "vue";
import {OrderListAPI, UpdateOrderAPI, CancelOrderAPI,GetOrderDetailAPI} from "@/views/fuadmin/mall/home/apis/order.api";
import dayjs from "dayjs";
import {ElMessage, ElMessageBox} from "element-plus";
import {DelCategoryAPI} from "@/views/fuadmin/mall/home/apis/category.api";
import {base_img_url} from "@/main";
//分页
const param = reactive({
  currentPage: 1,
  pageSize: 7,
  keyword: '',
  username: ''
})
const total = ref(0)
const handleSizeChange = async (val) => {
  param.pageSize = val
  await getOrderList()
}
const handleCurrentChange = async (val) => {
  param.currentPage = val
  await getOrderList()
}
//数据
const orderList = ref([])

//表格的id
const HandelIndex = (index) => {
  return index + 1 + (param.currentPage - 1) * (param.pageSize)
}
const getOrderList = async () => {
  const res = await OrderListAPI(param.currentPage, param.pageSize, param.keyword, param.username)
  total.value = res.total
  orderList.value = res.data
}
//发货
const updateOrder = async (id) => {
  const res = await UpdateOrderAPI(id)
  if (res.code === 200) {
    ElMessage.success('提交成功!!!')
    await getOrderList()
  } else if (res.code === 304) {
    ElMessage.warning(res.msg)
  } else {
    ElMessage.warning('提交失败')
  }
}
//取消
const cancelOrder = async (id) => {
  await CancelOrderAPI(id)
  ElMessage.success('取消成功!!!')
  await getOrderList()
}
const view = async () => {
  param.keyword = ''
  param.username = ''
  await getOrderList()
}
getOrderList()
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
//多选
const multipleSelection = ref([]);
const handleSelectionChange = (val) => {
  multipleSelection.value = val;
};
//处理日期
const formatTime = (time) => {
  return dayjs(time).format('YYYY-MM-DD HH:mm:ss');
};
//判断当前行
const rowSelectable = (row) => {
  return row.transaction_status !== 1
}
//全部提交
const allUpdate = async () => {
  ElMessageBox.confirm('确定要提交全部订单?', '订单', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'success'
  })
      .then(async () => {
        const arr = multipleSelection.value
        for (const item of arr) {
          await UpdateOrderAPI(item['id'])
        }
        // for (let item in multipleSelection.value) {
        //   console.log(item)
        //   // await UpdateOrderAPI(item.id)
        // }
        ElMessage.success('全部提交成功!!!')
        await getOrderList()
      })
      .catch(() => {
        ElMessage({
          type: 'info',
          message: '取消'
        })
      })
}
//全部取消
const allCancel = async () => {
  ElMessageBox.confirm('确定要取消全部订单?', '订单', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'success'
  })
      .then(async () => {
        const arr = multipleSelection.value
        for (const item of arr) {
          await CancelOrderAPI(item["id"])
        }
        ElMessage.success('全部取消成功!!!')
        await getOrderList()
      })
      .catch(() => {
        ElMessage({
          type: 'info',
          message: '取消'
        })
      })
}
//监听是否选择了数据
const checkSelect = ref(true)
watch(
    () => multipleSelection.value.length,
    (newLength) => {
      checkSelect.value = newLength <= 0;
    }
);
// 获取订单详情
const isLoading = ref(false)
const isDetail = ref(false)
const orderDetail = ref([])
const record = ref()
const getOrderDetail = async (row) => {
  record.value = row
  isLoading.value = true
  orderDetail.value = await GetOrderDetailAPI(row.order_number, row.user_id)
  isLoading.value = false
  isDetail.value = true
}
</script>

<template>
  <div>
    <el-card shadow="always">
      <el-row>
        <el-col :span="1">
          <el-button circle @click="view">
            <el-icon>
              <RefreshLeft/>
            </el-icon>
          </el-button>
        </el-col>
        <el-col :span="2">
          <el-button plain style="transition: background-color 1s;" type="primary"
                     @click="allUpdate" :disabled="checkSelect">全部提交
          </el-button>
        </el-col>
        <el-col :span="2">
          <el-button plain style="transition: background-color 1s;" type="warning"
                     @click="allCancel" :disabled="checkSelect">全部取消
          </el-button>
        </el-col>
        <el-col :span="6">
          <el-input clearable v-model="param.keyword" class="search-input" style="max-width: 400px"
                    placeholder="订单号搜索......">
            <template #prefix>
              <el-icon class="search-icon">
                <Search/>
              </el-icon>
            </template>
          </el-input>
        </el-col>
        <el-col :span="2">
          <el-button id="searchBtn" @click="getOrderList">点击搜索</el-button>
        </el-col>
        <el-col :span="6">
          <el-input clearable v-model="param.username" class="search-input" style="max-width: 400px"
                    placeholder="用户搜索......">
            <template #prefix>
              <el-icon class="search-icon">
                <Search/>
              </el-icon>
            </template>
          </el-input>
        </el-col>
        <el-col :span="2">
          <el-button id="searchBtn" @click="getOrderList">点击搜索</el-button>
        </el-col>
      </el-row>
      <el-table :data="orderList" height="auto" stripe  style="width: 100%;margin-top: 20px"
                @selection-change="handleSelectionChange">
<!--        :selectable="rowSelectable"-->
        <el-table-column type="selection" width="auto"/> >
        <el-table-column type="index" :index="HandelIndex" label="ID" width="auto"/>
        <el-table-column prop="order_number" label="订单号" width="auto"/>
        <el-table-column prop="username" label="用户名" width="auto"/>
        <el-table-column label="订单总金额" width="auto">
          <template #default="scope">
            <span>{{ scope.row.total_amount.toFixed(2).toString() }}元</span>
          </template>
        </el-table-column>
        <el-table-column label="支付金额" width="auto">
          <template #default="scope">
            <span>{{ scope.row.payment_amount.toFixed(2).toString() }}元</span>
          </template>
        </el-table-column>
        <el-table-column prop="payment_status" label="类型名称" width="auto">
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
        <el-table-column prop="recipient_phone" label="类型名称" width="auto"/>
        <el-table-column prop="recipient_address" label="收货人地址" width="auto">
          <template v-slot="scope">
            <el-popover effect="light" trigger="hover" placement="top" width="auto">
              <template #default>
                <el-tag>双击复制文本</el-tag>
                <div>{{ scope.row.recipient_address }}</div>
              </template>
              <template #reference>
                <el-text style="white-space: nowrap" @dblclick="copyToClipboard(scope.row.recipient_address)"
                >{{ scope.row.recipient_address }}
                </el-text>
              </template>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column prop="create_time" label="下单时间">
          <template v-slot="scope">
            {{ formatTime(scope.row.create_time) }}
          </template>
        </el-table-column>
        <el-table-column prop="checkout_time" label="结账时间">
          <template v-slot="scope">
            {{ formatTime(scope.row.checkout_time) }}
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template #default="scope">
            <el-button plain type="primary" size="small" @click="getOrderDetail(scope.row)">订单详情</el-button>
            <el-popconfirm title="确定提交该条订单吗?" @confirm="updateOrder(scope.row.id)">
              <template #reference>
      <span v-if="scope.row.transaction_status === 0">
        <el-button color="#7d7afc" plain size="small">提交订单</el-button>
      </span>
              </template>
            </el-popconfirm>
            <el-tag color="" v-if="scope.row.transaction_status === 1">已提交</el-tag>
            <el-tag color="yellow" v-if="scope.row.transaction_status === 2">已取消</el-tag>
            <el-popconfirm title="确定要取消该条订单吗?" @confirm="cancelOrder(scope.row.id)">
              <template #reference>
      <span v-if="scope.row.transaction_status === 1">
        <el-button type="warning" size="small" plain>取消订单</el-button>
      </span>
              </template>
            </el-popconfirm>
          </template>

        </el-table-column>
      </el-table>
      <el-pagination style="margin-top: 20px"
                     v-model:current-page="param.currentPage"
                     v-model:page-size="param.pageSize"
                     :page-sizes="[7,10, 20, 30]"
                     :small="false"
                     :disabled="false"
                     :background="false"
                     layout="total, sizes, prev, pager, next, jumper"
                     :total="total"
                     @size-change="handleSizeChange"
                     @current-change="handleCurrentChange"
      />
    </el-card>
    <el-dialog v-model="isDetail" title="订单详情">
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
            <el-table-column prop="product_num" label="数量"/>
          </el-table>
    </el-dialog>
  </div>
</template>
<style lang="less" scoped>
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

</style>
