<script>
import service from '@/utils/request.js'
import { ElMessage } from 'element-plus'
import pca from '@/assets/adress/pca-code.json'

export default {
  data() {
    return {
      addressData: [], //table绑定表格数据
      addressEdit: [], //用于动态修改行内数据
      addressInput: {
        adname: '',
        adphone: '',
        adpca: '',
        addetail: '',
        adisdefault: 0
      },
      total:0,
      pcaOptions: pca,
      addressProps: {
        label: 'name',
        children: 'children',
        value: 'name'
      },
      params: {
        currentPage: 1,
        pageSize: 6
      }
    }
  },
  created() {
    this.loadAddressData()
  },
  methods: {
    handleCurrentChange(val) {
      this.params.currentPage = val
      this.loadAddressData()
    },
    // 以下为 loadAddressData 方法的完善
    loadAddressData() {
      // 发送请求获取数据
      service({
        method: 'get',
        url: '/mall/address/v1/list',
        params: this.params
      })
        .then((response) => {
          // 处理成功响应
          this.addressData = response.data.result.data
          this.addressEdit = new Array(this.addressData.length).fill(false)
          this.total = response.data.result.total
        })
        .catch((error) => {
          // 处理错误响应
          console.error('Failed to fetch address data:', error)
          // 可以添加一些提示用户的逻辑，比如 ElMessage 提示
        })
    },
    addAddress() {
      // 创建一个新的地址对象，可以根据你的数据结构进行修改
      const newAddress = {
        username: this.addressInput.adname,
        contact_number: this.addressInput.adphone,
        delivery_address: this.addressInput.adpca,
        detailed_address: this.addressInput.addetail,
        is_default: this.addressInput.adisdefault
      }
      // 发起后端请求，将新地址保存到数据库
      service({
        method: 'post', // 根据实际情况使用 post 或其他 HTTP 方法
        url: '/mall/address/v1/add', // 修改为你的后端地址
        data: newAddress
      })
        .then((response) => {
          if(response.data.code===200){
            ElMessage.success('创建成功!!!')
          } else {
            ElMessage.warning(response.data.message)
          }
          // 刷新地址数据，如果需要
          this.loadAddressData()
        })
        .catch((error) => {
          // 请求失败处理
          console.error('Error adding address:', error)
        })
      // 添加新地址到前端数据

      // 添加新地址到前端数据（在数组的开头）
      this.addressData.unshift(newAddress)
      // 设置新地址为编辑状态
      this.addressEdit[0] = true
    },
    editAddress(index) {
      this.addressEdit[index] = !this.addressEdit[index]
    },
    saveAddress(index, editedAddress) {
      if(editedAddress.delivery_address !=null && editedAddress.delivery_address.length>0){
        if (Array.isArray(editedAddress.delivery_address)) {
          // 执行 join 操作
          editedAddress.delivery_address = editedAddress.delivery_address.join('/') || null;
        }
      }
      // 1. 发起后端请求，将编辑后的地址保存到数据库
      service({
        method: 'put', // 根据实际情况使用 put 或其他 HTTP 方法
        url: '/mall/address/v1/update', // 修改为你的后端地址
        data: editedAddress
      })
        .then((response) => {
          if (response.data.code === 200) {
            ElMessage.success('保存成功!!!')
          } else {
            ElMessage.warning(response.data.message)
          }
          // 2. 刷新地址数据，如果需要
          this.loadAddressData()
        })
        .catch((error) => {
          // 请求失败处理
          console.error('Error updating address:', error)
        })

      // 3. 结束编辑状态
      this.addressEdit[index] = false
    },
    deleteAddress(index, id) {
      // this.addressData.splice(index, 1)
      // 1. 发起后端请求，将编辑后的地址保存到数据库
      service({
        method: 'delete', // 根据实际情况使用 put 或其他 HTTP 方法
        url: '/mall/address/v1/delete', // 修改为你的后端地址
        params: { id }
      })
        .then((response) => {
          if (response.data.code === 200) {
            ElMessage.success('删除成功!!!')
          } else {
            ElMessage.warning(response.data.message)
          }
          // 2. 刷新地址数据，如果需要
          this.loadAddressData()
        })
        .catch((error) => {
          // 请求失败处理
          console.error('Error updating address:', error)
        })
    },
    handleAddressNode(value) {
      console.log(value)
      //value为数组
      this.addressData.adpca = value[2] //三级级联地址，只需要把第三级存入数据库即可
    },
    changetest() {
      // console.log(typeof val)
      // console.log(val)
    },
    //拼接字符串
    changeAddress(value){
      return value.join('/')
    }

  }
}
</script>

<template>
  <div class="container">
    <div style="padding: 30px">
      <el-card class="box-card;" shadow="always" style="width: 93%">
        <template #header>
          <div class="card-header" style="text-align: left">
            <span>管理地址</span>
            <el-button class="button" type="text" @click="addAddress">新增</el-button>
          </div>
          <el-table :data="addressData" style="width: 100%" ref="table">
            <el-table-column type="index"></el-table-column>
            <el-table-column prop="username" label="收货人" width="100">
              <template #default="scope">
                <el-input size="default" v-model="scope.row.username" v-if="addressEdit[scope.$index]"></el-input>
                <span v-else>{{ scope.row.username }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="contact_number" label="联系方式" width="140">
              <template #default="scope">
                <el-input size="default" v-model="scope.row.contact_number" v-if="addressEdit[scope.$index]"></el-input>
                <span v-else>{{ scope.row.contact_number }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="delivery_address" v-if="delivery_address" label="收货地址" width="240" align="center">

            </el-table-column>
            <el-table-column prop="delivery_address" v-else label="收货地址" width="240" align="center">
              <template #default="scope" >
                <!--级联选择器选择地址-->
                <el-cascader v-if="addressEdit[scope.$index]"
                  v-model="scope.row.delivery_address"
                  :options="pcaOptions"
                  :props="addressProps"
                  placeholder="请选择"
                  @change="handleAddressNode"
                  filterable
                  :disabled="!addressEdit[scope.$index]"
                ></el-cascader>
                <span v-else>{{ scope.row.delivery_address }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="detailed_address" label="详细地址" width="180">
              <template #default="scope">
                <el-input size="default" v-model="scope.row.detailed_address" v-if="addressEdit[scope.$index]"></el-input>
                <span v-else>{{ scope.row.detailed_address }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="is_default" label="默认地址" width="100">
              <template #default="scope">
                <div v-if="addressEdit[scope.$index]">
                  <el-checkbox v-model="scope.row.is_default" :true-label="1" :false-label="0" @change="changetest"> 设为默认 </el-checkbox>
                </div>
                <div v-else>
                  <el-tag v-if="scope.row.is_default === 1" type="success" size="small">默认</el-tag>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="操作" align="center" width="180">
              <template #default="scope">
                <el-button size="small" icon="el-icon-edit" v-if="!addressEdit[scope.$index]" @click="editAddress(scope.$index)">编辑 </el-button>
                <el-button size="small" icon="el-icon-check" v-else @click="saveAddress(scope.$index, scope.row)">保存 </el-button>
                <el-popconfirm confirmButtonText="好的" cancelButtonText="不用了" icon="el-icon-info" title="确定删除该地址？" @confirm="deleteAddress(scope.$index, scope.row.id)">
                  <template #reference>
                    <el-button size="small" icon="el-icon-delete">删除</el-button>
                  </template>
                </el-popconfirm>
              </template>
            </el-table-column>
          </el-table>
        </template>
        <el-pagination
            v-model:current-page="params.currentPage"
            v-model:page-size="params.pageSize"
            :small="false"
            :disabled="false"
            :background="false"
            layout="prev, pager, next,total"
            :total="total"
            @current-change="handleCurrentChange"
        />
      </el-card>
    </div>
  </div>
</template>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-header span {
  color: #b1b3b8;
}
</style>
