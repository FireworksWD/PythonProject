<script setup lang="ts">
import {reactive, ref} from "vue";
import {Plus, RefreshLeft, Search, StarFilled} from "@element-plus/icons-vue";
import {
  getCategoryListAPI,
  getProductListAPI,
  deleteProductAPI,
  detailProductAPI,
  submitAPI
} from './apis/product.api'
import {base_img_url} from "@/main";
import {ElMessage, ElMessageBox} from "element-plus";
import {useUserStore} from "@/store/modules/user";

const userStore = useUserStore();
const isCreated = ref(false)
//存图片链接的
const headerImg = reactive({
  img: ''
})
//编辑页面
const dialogTableVisible = ref(false)
const productDetail = ref({
  id: '',
  name: '',
  price: '',
  number: '',
  description: '',
  img_url: '',
  categoryName: ''
})
const title = ref()
//分页
const param = reactive({
  currentPage: 1,
  pageSize: 7,
  keyword: ''
})
const total = ref(400)
const handleSizeChange = async (val: any) => {
  param.pageSize = val
  await getProductList()
}
const handleCurrentChange = async (val: any) => {
  param.currentPage = val
  await getProductList()
}
//选择器的结果
const selectValue = ref()
//修改的时候不能修改商品名字
const isUpdate = ref(false)
//弹出框
const handleDialogChange = async (val: any, id) => {
  //新增
  if (val == 1) {
    isCreated.value = true
    title.value = '新增商品'
    dialogTableVisible.value = true
    productDetail.value = {
      id: '',
      name: '',
      price: '0',
      number: '0',
      description: '',
      img_url: '',
      categoryName: ''
    }
  } else {
    isUpdate.value = true
    isCreated.value = false
    title.value = '商品详情'
    dialogTableVisible.value = true
    productDetail.value = await detailProductAPI(id)
    selectValue.value = productDetail.value.categoryName.split('/')
  }
}
//商品数据
const productList = ref()
//分类数据
const categoryList = ref()
const getProductList = async () => {
  const res = await getProductListAPI(param.currentPage, param.pageSize, param.keyword)
  productList.value = res.data
  total.value = res.total
}
const getCategoryList = async () => {
  categoryList.value = await getCategoryListAPI()
}
//提交
const submit = async () => {
  productDetail.value.categoryName = selectValue.value.join('/')
  const product_id = productDetail.value.id
  const data = {
    "name": productDetail.value.name,
    "price": productDetail.value.price,
    "number": productDetail.value.number,
    "description": productDetail.value.description,
    "categoryName": productDetail.value.categoryName,
    "img_url": headerImg.img
  }
  const res = await submitAPI(isCreated.value, data, product_id)
  if (res.code === 399) {
    ElMessage.warning('该商品已经存在!!!')
  } else {
    ElMessage.success('成功!!')
    dialogTableVisible.value = false
  }
  isUpdate.value = false
  await getProductList()
}
//删除商品
const delProduct = (product_id) => {
  ElMessageBox.confirm('你确定要删除该条商品?', '商品', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'success'
  })
    .then(async () => {
      const res = await deleteProductAPI(product_id)
      if (res.code === 200) {
        ElMessage.success('删除成功!!!')
      } else {
        ElMessage.warning('删除失败')
      }
      await getProductList()
    })
    .catch(() => {
      ElMessage({
        type: 'info',
        message: '取消'
      })
    })
}
const view = async () => {
  param.keyword=''
  await getProductList()
  await getCategoryList()
}
getProductList()
getCategoryList()
//文件上传
const uploadSuccess = async (res, upload) => {
  if (res.result.code === 200) {
    ElMessage({
      type: 'success',
      message: '上传成功'
    })
    headerImg.img = res.result.img_url
    await getProductList()
    productDetail.value = await detailProductAPI(res.result.id)
    selectValue.value = productDetail.value.categoryName.split('/')
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
const closeHandel = () => {
  headerImg.img = ''
  isUpdate.value = false
}
//表格的id
const HandelIndex = (index) => {
  return index + 1 + (param.currentPage - 1) * (param.pageSize)
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
          <el-button plain id="searchBtn" size="default" type="primary"
                     @click="handleDialogChange(1,null)">新增
          </el-button>
        </el-col>
        <el-col :span="6">
          <el-input clearable v-model="param.keyword" class="search-input" style="max-width: 400px"
                    placeholder="商品名搜索......">
            <template #prefix>
              <el-icon class="search-icon">
                <Search/>
              </el-icon>
            </template>
          </el-input>
        </el-col>
        <el-col :span="3">
          <el-button id="searchBtn" @click="getProductList">点击搜索</el-button>
        </el-col>
      </el-row>
      <el-table :data="productList" height="auto" style="width: 100%;margin-top: 20px">
        <el-table-column type="index" :index="HandelIndex" label="ID" width="auto"/>
        <el-table-column prop="img_url" label="图片" width="200">
          <template v-slot="{ row }">
            <el-image
              v-if="base_img_url + row.img_url"
              :src="base_img_url + row.img_url"
              alt="封面"
              :preview-src-list="[base_img_url + row.img_url]"
              :preview-teleported="true"
              style="width: auto; height: 40px; border: none; cursor: pointer"
            />
            <span v-else>暂无图片</span>
          </template>
        </el-table-column>
        <el-table-column prop="name" label="商品名称" width="auto">
          <template v-slot="scope">
            <el-popover effect="light" trigger="hover" placement="top" width="auto">
              <template #default>
                <div>{{ scope.row.name }}</div>
              </template>
              <template #reference>
                <el-text style="white-space: nowrap" @dblclick="copyToClipboard(scope.row.name)"
                >{{ scope.row.name }}
                </el-text>
              </template>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column prop="price" label="价格"/>
        <el-table-column prop="description" label="描述" width="auto">
          <template v-slot="scope">
            <el-popover effect="light" trigger="hover" placement="top" width="auto">
              <template #default>
                <div>{{ scope.row.description }}</div>
              </template>
              <template #reference>
                <el-text style="white-space: nowrap" @dblclick="copyToClipboard(scope.row.description)"
                >{{ scope.row.description }}
                </el-text>
              </template>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column prop="number" label="库存" width="auto"/>
        <el-table-column prop="categoryName" label="类型" width="auto">
          <template v-slot="scope">
            <el-popover effect="light" trigger="hover" placement="top" width="auto">
              <template #default>
                <el-tag>双击复制文本</el-tag>
                <div>{{ scope.row.categoryName }}</div>
              </template>
              <template #reference>
                <el-text style="white-space: nowrap" @dblclick="copyToClipboard(scope.row.categoryName)"
                >{{ scope.row.categoryName }}
                </el-text>
              </template>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template #default="scope">
            <el-button color="#3074d0" plain @click="handleDialogChange(0,scope.row.id)">编辑
            </el-button>
            <el-button color="#cf4444" plain @click="delProduct(scope.row.id)">删除</el-button>
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

    <el-dialog v-model="dialogTableVisible" :title="title" width="800" @close="closeHandel">
      <el-card shadow="always" class="product-detail-card" v-model="productDetail">
        <el-row type="flex" justify="center" align="middle">
          <el-col :span="10" style="width: 100vw;height: auto">
            <el-upload
              :limit="1"
              class="upload-demo"
              drag
              :action="`${base_img_url}/api/mall/product/v1/upload?id=${productDetail.id}`"
              :headers="{'Authorization':`${userStore.getToken}`}"
              multiple
              accept=".jpg, .png"
              :on-success="uploadSuccess"
              :on-error="uploadError"
            >
              <el-image w-full v-if="productDetail.img_url"
                        :src="base_img_url+productDetail.img_url"/>
              <el-image w-full v-else-if="headerImg.img"
                        :src="base_img_url+'/media/'+headerImg.img"/>
              <el-icon>
                <Plus />
              </el-icon>
              <template #tip>
                <div class="el-upload__tip">
                  jpg/png files
                </div>
              </template>
            </el-upload>
          </el-col>
          <el-col :span="1"></el-col>
          <el-col :span="13">
            <el-row style="margin-top: 20px">
              <el-col :span="3">
                <el-text>商品名:</el-text>
              </el-col>
              <el-col :span="15">
                <el-input required  :disabled="isUpdate" v-model="productDetail.name"></el-input>
              </el-col>
            </el-row>
            <el-row style="margin-top: 20px">
              <el-col :span="3">
                <el-text>价格:</el-text>
              </el-col>
              <el-col :span="15">
                <el-input-number min="0" v-model="productDetail.price"></el-input-number>
              </el-col>
            </el-row>
            <el-row style="margin-top: 20px">
              <el-col :span="3">
                <el-text>库存:</el-text>
              </el-col>
              <el-col :span="15">
                <el-input-number min="0" v-model="productDetail.number"></el-input-number>
              </el-col>
            </el-row>
            <el-row style="margin-top: 20px">
              <el-col :span="3">
                <el-text>描述:</el-text>
              </el-col>
              <el-col :span="21">
                <el-input type="textarea" v-model="productDetail.description"></el-input>
              </el-col>
            </el-row>
            <el-row style="margin-top: 20px">
              <el-col :span="3">
                <el-text>类型:</el-text>
              </el-col>
              <el-col :span="15">
                <el-select
                  v-model="selectValue"
                  clearable
                  multiple
                  collapse-tags
                  collapse-tags-tooltip
                  placeholder="Select"
                  size="4"
                >
                  <el-option
                    v-for="item in categoryList"
                    :key="item.id"
                    :label="item.categoryName"
                    :value="item.categoryName"
                  />
                </el-select>
              </el-col>
            </el-row>
          </el-col>
        </el-row>
        <el-divider>
          <el-icon>
            <star-filled/>
          </el-icon>
        </el-divider>
        <el-row type="flex" justify="end">
          <el-button plain id="searchBtn" size="large" @click="submit">提交</el-button>
        </el-row>
      </el-card>
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

.product-detail-card {
  margin-bottom: 20px;
}

.product-item {
  margin-bottom: 10px;
}

.product-item-row {
  display: flex;
  align-items: center;
}

.label-col {
  font-weight: bold;
}

.value-col {
  margin-left: 10px;
}

.upload-demo {
  height: auto;
  width: auto;
}
</style>
