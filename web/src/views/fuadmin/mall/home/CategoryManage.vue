<script setup>
import {reactive, ref} from "vue";
import {RefreshLeft, Search} from "@element-plus/icons-vue";
import {AddCategoryAPI, CategoryListAPI, DelCategoryAPI} from "@/views/fuadmin/mall/home/apis/category.api";
import {base_img_url} from "@/main";
import {ElMessage, ElMessageBox} from "element-plus";
import {deleteProductAPI} from "@/views/fuadmin/mall/home/apis/product.api";
//分页
const param = reactive({
  currentPage: 1,
  pageSize: 7,
  keyword: ''
})
const total = ref(400)
const handleSizeChange = async (val) => {
  param.pageSize = val
  await getCategoryList()
}
const handleCurrentChange = async (val) => {
  param.currentPage = val
  await getCategoryList()
}
//数据
const categoryList = ref()
const getCategoryList = async () => {
  const res = await CategoryListAPI(param.currentPage, param.pageSize, param.keyword)
  total.value = res.total
  categoryList.value = res.data
}
//删除
const delCategory = async (id) => {
  ElMessageBox.confirm('你确定要删除该条信息?', '类型', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'success'
  })
      .then(async () => {
        const res = await DelCategoryAPI(id)
        if (res.code === 200) {
          ElMessage.success('删除成功!!!')
          await getCategoryList()
        } else if (res.code === 304) {
          ElMessage.warning(res.msg)
        } else {
          ElMessage.warning('删除失败')
        }
      })
}
const body = reactive({
  categoryName: ''
})
//编辑页面
const dialogTableVisible = ref(false)
//增加
const addCategory = async () => {
  dialogTableVisible.value = true
}
const submit = async () => {
  const res = await AddCategoryAPI(body)
  if (res.code === 304) {
    ElMessage.warning(res.msg)
  }
  if (res.code === 200) {
    dialogTableVisible.value = false
    ElMessage.success("成功!!")
    await getCategoryList()
  }
}
//表格的id
const HandelIndex = (index) => {
  return index + 1 + (param.currentPage - 1) * (param.pageSize)
}
const view = async () => {
  param.keyword = ''
  await getCategoryList()
}
getCategoryList()
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
                     @click="addCategory">新增
          </el-button>
        </el-col>
        <el-col :span="6">
          <el-input clearable v-model="param.keyword" class="search-input" style="max-width: 400px"
                    placeholder="名称搜索......">
            <template #prefix>
              <el-icon class="search-icon">
                <Search/>
              </el-icon>
            </template>
          </el-input>
        </el-col>
        <el-col :span="3">
          <el-button id="searchBtn" @click="getCategoryList">点击搜索</el-button>
        </el-col>
      </el-row>
      <el-table :data="categoryList" height="auto" style="width: 100%;margin-top: 20px">
        <el-table-column type="index" :index="HandelIndex" label="ID" width="auto"/>
        <el-table-column prop="categoryName" label="类型名称" width="auto"/>
        <el-table-column label="操作">
          <template #default="scope">
            <el-button color="#cf4444" plain @click="delCategory(scope.row.id)">删除</el-button>
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

    <el-dialog v-model="dialogTableVisible" title="新增类型" width="800">
      <el-card shadow="always" class="product-detail-card">
        <el-row type="flex" justify="center" align="middle">
          <el-col :span="3">
            <el-text>类型名称:</el-text>
          </el-col>
          <el-col :span="15">
            <el-input v-model="body.categoryName"></el-input>
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
