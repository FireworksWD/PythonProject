<script setup>
import {formatTime} from '@/utils/format.js'
import { onMounted, onUpdated, ref} from 'vue'
import {useRoute} from 'vue-router'
import {PageByCategoryIdAPI} from '@/api/product.js'
import {base_img_url} from "@/main.js";

// 初始化加载数量和加载函数
const total = ref(0)
const route = useRoute()
const params = ref({
  currentPage: 1,
  pageSize: 12,
  categoryId: ''
})

const dataList = ref([])
// 获取数据
const getdataList = async () => {
  params.value.categoryId = route.params.id
  const res = await PageByCategoryIdAPI(params.value)
  dataList.value = res.data.result.data
  total.value = res.data.result.total
}
onMounted(() => {
  getdataList()
})
onUpdated(() => {
  dataList.value = []
  getdataList()
})

// 加载事件文字
const handelCategory = (text) => {
  return text.split('/').length > 1 ? text.split('/').slice(0, 1).toString() + '......' : text.split('/').slice(0, 1).toString()
}
//名称
const handelName = (text) => {
  return text.length > 5 ? text.slice(0, 5) + '...' : text
}
const handleCurrentChange = (val) => {
  params.value.currentPage = val
  getdataList()
}
</script>

<template>
  <el-card class="container">
    <div class="book-list-container">
      <h1 class="section-title">电器</h1>
      <div class="book-list">
        <el-row :gutter="20">
          <el-col :span="6" v-for="data in dataList" :key="data.id">
            <!-- <a :href="`/detail/${book.id}`"> </a>-->
            <RouterLink :to="`/detail/${data.id}`">
              <el-card shadow="hover" class="book-card">
                <img :src="base_img_url+data.img_url" class="book-image" alt="" />
                <div class="book-info">
                  <el-tooltip :content="data.categoryName" effect="light">
                    <el-tag size="large" style="text-align: center; display: inline-flex; align-items: center;">
                      {{ handelCategory(data.categoryName) }}
                    </el-tag>
                  </el-tooltip>
                  <el-tooltip :content="data.name" effect="light">
                    <span class="name">名称： {{ handelName(data.name) }}</span>
                  </el-tooltip>
                </div>
                <div class="info-bottom">
                  <div class="price">￥{{ data.price }}</div>
                  <div class="time">{{ formatTime(data.create_time) }}</div>
                </div>
              </el-card>
            </RouterLink>
          </el-col>
        </el-row>
      </div>
    </div>
    <el-pagination
        v-model:current-page="params.currentPage"
        v-model:page-size="params.pageSize"
        :small="false"
        :disabled="false"
        :background="false"
        layout="prev, pager, next, total"
        :total="total"
        @current-change="handleCurrentChange"
    />
  </el-card>
</template>

<style scoped lang="scss">
.book-list-container {
  text-align: center;

  .section-title {
    text-align: left;
    color: #27ba9b;
    margin-bottom: 20px;
  }

  .book-list {
    //overflow: auto;
  }

  .book-card {
    height: 350px;
    margin-bottom: 25px;

    img {
      transition: 0.5s ease-in-out;
    }

    img:hover {
      transform: scale(1.05);
      transform-style: flat;

      .name {
      }
    }

    .book-info {
      padding: 10px;
      text-align: center;
      display: flex;
      justify-content: space-between;
      height: 100%;

      span {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
      }

      .category {
        font-size: 18px;
        //margin-right: 40px;
        padding-right: 40px;
        font-weight: bold;
      }

      .name {
        font-weight: bold;
        color: #67c23a;
        font-size: 16px;
      }

      .info-bottom {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
      }
    }

    .price {
      color: #e74c3c;
      font-size: 20px;
      margin-bottom: 5px;
    }

    .book-image {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 8px;
    }
  }
}

.loading-message,
.no-more-message {
  margin-top: 20px;
  color: #666;
}

.time {
  font-size: 13px;
  color: #999;
}
</style>
