<script setup>
import {computed, ref} from 'vue'
import {formatTime} from '@/utils/format.js'
import {productPageAPI, imgRandomAPI} from '@/api/product.js'
import {base_img_url} from '@/main.js'

// const card = [
//   {src: new URL('@/assets/image/card1.jpeg', import.meta.url).href},
//   {src: new URL('@/assets/image/card2.jpeg', import.meta.url).href},
//   {src: new URL('@/assets/image/card3.jpeg', import.meta.url).href}
// ]
const card = ref([])
const randomImg = async () => {
  const res = await imgRandomAPI()
  card.value = res.data.result
  console.log(card.value)
}
randomImg()
// 初始化加载数量和加载函数
const loading = ref(false)
const count = ref(0)
const total = ref(0)
const params = ref({
  currentPage: 1,
  pageSize: 5,
  keyword: null
})
// 是否继续加载
const noMore = computed(() => {
  return count.value >= total.value
})
const disabled = computed(() => {
  return loading.value || noMore.value
})

const productList = ref([])
//带参数的
const producKeywordtList = ref([])
//
// const productList = ref([
//   {
//     id: '1737577604845258483',
//     name: '海的女儿',
//     categoryId: 10056,
//     author: '安徒生',
//     price: 59.0,
//     stock: 1000,
//     image: 'https://haruna.oss-cn-wuhan-lr.aliyuncs.com/book/bdaea019-104e-4a05-8b4f-15a640f1ef1f.png',
//     status: 1,
//     description: '童话故事',
//     createTime: '2023-12-21 04:47:55',
//     updateTime: '2023-12-21 04:52:04',
//     isDeleted: 0,
//     categoryName: '童话'
//   }
// ])
// 获取数据
const getproductList = async () => {
  loading.value = true
  const res = await productPageAPI(params.value)
  if (isKeyword.value === false) {
    productList.value = [...productList.value, ...res.data.result.data]
    count.value = productList.value.length
  } else {
    producKeywordtList.value = [...producKeywordtList.value, ...res.data.result.data]
    count.value = producKeywordtList.value.length
  }
  total.value = res.data.result.total
  loading.value = false
}

getproductList()

// 加载事件
const load = () => {
  params.value.currentPage += 1
  getproductList()
}
//处理文字
const handelCategory = (text) => {
  return text.split('/').length > 1 ? text.split('/').slice(0, 1).toString() + '......' : text.split('/').slice(0, 1).toString()
}
//名称
const handelName = (text) => {
  return text.length > 5 ? text.slice(0, 5) + '...' : text
}
//监听数据
const isKeyword = ref(false)
// watchEffect(() => {
//   isKeyword.value = !!params.value.keyword;
// });
const onCheck = async () => {
  params.value.currentPage = 1
  params.value.pageSize = 5
  productList.value = []
  producKeywordtList.value = []
  if (params.value.keyword.length <= 0) {
    isKeyword.value = false
    await getproductList()
  } else {
    isKeyword.value = true
    await getproductList()
  }
}
</script>

<template>
  <div class="BookCard" style="padding-top: 20px">

    <el-carousel :interval="2500" type="card" height="300px">
      <el-carousel-item v-for="item in card" :key="item.id">
        <RouterLink :to="`/detail/${item.id}`">
          <el-image :src="base_img_url + item.img_url" alt="" style="width: 100%; height: 100%; object-fit: contain">
            <div class="overlay-text">
              推荐商品:
              {{ item.name }}
            </div>
          </el-image>
        </RouterLink>
      </el-carousel-item>
    </el-carousel>
  </div>
  <el-input placeholder="按商品名称搜索......" class="search-input" v-model="params.keyword" :trigger-on-focus="true">
    <template #suffix>
      <el-button id="searchBtn" @click="onCheck">点击搜索</el-button>
    </template>
  </el-input>
  <!-- 热门列表 -->
  <el-card class="container" v-if="!isKeyword">
    <div class="book-list-container" v-infinite-scroll="load" :infinite-scroll-disabled="disabled">
      <h1 class="section-title">热门家电</h1>
      <div class="book-list">
        <el-row :gutter="20">
          <el-col :span="6" v-for="product in productList" :key="product.id">
            <!-- <a :href="`/detail/${book.id}`"> </a>-->
            <RouterLink :to="`/detail/${product.id}`">
              <el-card shadow="hover" class="book-card">
                <img :src="base_img_url + product.img_url" class="book-image" alt=""/>
                <div class="book-info">
                  <el-tooltip :content="product.categoryName" effect="light">
                    <el-tag size="large" style="text-align: center; display: inline-flex; align-items: center;">
                      {{ handelCategory(product.categoryName) }}
                    </el-tag>
                  </el-tooltip>
                  <el-tooltip :content="product.name" effect="light">
                    <span class="name">名称： {{ handelName(product.name) }}</span>
                  </el-tooltip>
                </div>
                <div class="info-bottom">
                  <div class="price">￥{{ product.price }}</div>
                  <div class="time">{{ formatTime(product.create_time) }}</div>
                </div>
              </el-card>
            </RouterLink>
          </el-col>
        </el-row>
        <p v-if="loading " class="loading-message">加载中...</p>
        <p v-if="noMore" class="no-more-message">没有更多了</p>
      </div>
    </div>
  </el-card>
  <el-card class="container" v-else>
    <div class="book-list-container" v-infinite-scroll="load" :infinite-scroll-disabled="disabled">
      <h1 class="section-title">热门家电</h1>
      <div class="book-list">
        <el-row :gutter="20">
          <el-col :span="6" v-for="product in producKeywordtList" :key="product.id">
            <!-- <a :href="`/detail/${book.id}`"> </a>-->
            <RouterLink :to="`/detail/${product.id}`">
              <el-card shadow="hover" class="book-card">
                <img :src="base_img_url + product.img_url" class="book-image" alt=""/>
                <div class="book-info">
                  <el-tooltip :content="product.categoryName" effect="light">
                    <el-tag size="large" style="text-align: center; display: inline-flex; align-items: center;">
                      {{ handelCategory(product.categoryName) }}
                    </el-tag>
                  </el-tooltip>
                  <el-tooltip :content="product.name" effect="light">
                    <span class="name">名称： {{ handelName(product.name) }}</span>
                  </el-tooltip>
                </div>
                <div class="info-bottom">
                  <div class="price">￥{{ product.price }}</div>
                  <div class="time">{{ formatTime(product.create_time) }}</div>
                </div>
              </el-card>
            </RouterLink>
          </el-col>
        </el-row>
        <p v-if="loading" class="loading-message">加载中...</p>
        <p v-if="noMore" class="no-more-message">没有更多了</p>
      </div>
    </div>
  </el-card>
  <el-backtop :bottom="100">
    <div
        style="
    height: 50px;
    width: 50px;
    background-color: var(--el-bg-color-overlay);
    box-shadow: var(--el-box-shadow-lighter);
    text-align: center;
    line-height: 50px;
    color: #1989fa;
    transition: background-color 0.3s, box-shadow 0.3s, transform 0.1s;
    cursor: pointer;
    border-radius: 50%;
    "
        onmouseover="this.style.backgroundColor='#2196f3'; this.style.boxShadow='0 4px 8px rgba(0,0,0,0.2)'; this.style.transform='scale(1.05)';"
        onmouseout="this.style.backgroundColor='var(--el-bg-color-overlay)'; this.style.boxShadow='var(--el-box-shadow-lighter)'; this.style.transform='scale(1)';"
        title="回到顶部"
    >
      &#9650;
    </div>
  </el-backtop>
</template>

<style scoped lang="scss">
.overlay-text {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: white;
  font-size: 18px;
  font-weight: bold;
  text-align: center;
  text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.8); /* 可选的文本阴影效果 */
}

.search-input {
  flex-grow: 1; /* 允许输入框占据更多空间 */
  margin-right: 80px; /* 给按钮留出空间 */
  margin-left: 147px;
  width: 500px;
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

.BookCard {
  width: 1340px;
  text-align: center;
  margin: auto auto 20px;
  font-family: 'Helvetica Neue', Helvetica, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', '微软雅黑', Arial, sans-serif;
}

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
      margin-top: 10px;

      span {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
      }

      .category {
        background-color: #f0f0f0;
        color: #333;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 14px;
        margin-right: 10px;
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
