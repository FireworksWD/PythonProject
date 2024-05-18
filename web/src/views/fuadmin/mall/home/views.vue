<script setup lang="ts">
import Pie from './charts-view/pie.vue'
import Line from './charts-view/line.vue'
import {reactive, ref, watchEffect} from "vue";
import {
  GetHotProductAPI,
  GetKeywordAPI,
  GetProductAPI,
  GetAddressProductAPI
} from './apis/echarts.api'
//当前时间
const nowDate = ref()
// 库存
const product_inventory = ref()
//热门
const hot_product = ref()
//关键字
const hot_keyword = ref()
//热门地区的销售额
const line_data = ref()
const isload = ref(false)
const getData = async () => {
  const lines = await GetAddressProductAPI()
  const v1 = await GetProductAPI()
  const v2 = await GetKeywordAPI()
  const v3 = await GetHotProductAPI()
  product_inventory.value = v1
  hot_keyword.value = v2
  hot_product.value = v3
  line_data.value = lines
  isload.value=true
  // console.log([product_inventory.value])
  // console.log([hot_keyword.value])
  // console.log([hot_product.value])
  // console.log(line_data.value)
}
getData()
const displayCurrentTime = () => {
  const now = new Date();
  const year = now.getFullYear().toString();
  const month = (now.getMonth() + 1).toString().padStart(2, '0'); // 注意月份是从0开始的，所以要加1
  const day = now.getDate().toString().padStart(2, '0');
  const hours = now.getHours().toString().padStart(2, '0');
  const minutes = now.getMinutes().toString().padStart(2, '0');
  const seconds = now.getSeconds().toString().padStart(2, '0');
  nowDate.value = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
}
// 每秒更新一次时间
setInterval(displayCurrentTime, 1000);
// 每小时刷新一次数据
setInterval(getData, 360000)
const config = reactive({
  header: ['商品名', '类型', '库存'],
  data: product_inventory.value,
  index: true,
  columnWidth: [50],
  align: ['center'],
})
const config1 = reactive({
  data: hot_product.value,
  unit: '',
})
const config2 = reactive({
  data: hot_keyword.value,
  unit: '',
})
//监听数据变化
watchEffect(() => {
  config.data = product_inventory.value
  config1.data = hot_product.value
  config2.data = hot_keyword.value
})
</script>
<template>
  <div style="background-color: #0B2541;height: 100%">
    <div id="title" class="title-area">
      <div style="width: 15%">
        <dv-decoration1/>
      </div>
      <!--        <div style="width: 5%"></div>-->
      <div style="width: 70%;text-align: center;">
        <dv-decoration7>
          <div style="margin-right: 0">
            <dv-decoration6/>
          </div>
          <div style="position: relative; text-align: center;">
            <!--            <dv-decoration5 :dur="2" style="position: absolute; top: -20px;" />-->
            <dv-decoration2 style="position: absolute; top: -20px;" :dur="2"/>
            <dv-button border="Border4" color="#a6559d" style="font-size: 20px;">
              <span style="font-size: 40px">纷飞家电数字大屏</span>
            </dv-button>
          </div>
          <div style="margin-left: 0">
            <dv-decoration6/>
          </div>
        </dv-decoration7>
      </div>
      <div style="width: 15%">
        <dv-decoration-9>
          <div style="font-size: 18px">
            {{ nowDate }}
  -        </div>
        </dv-decoration-9>
      </div>
    </div>

    <div id="middle" class="middle-area">
      <div id="chart2" class="chart_items">
        <dv-border-box8>
          <div style="  background: linear-gradient(to right, #0D3DB6 0%, #052678 50%, #0C2542 100%);
  color: white;
  font-size: 18px;  margin-left: 30px;margin-top: 20px;margin-right: 30px;text-align: center">
            热门商品Top10
          </div>
          <dv-scroll-ranking-board :config="config1"
                                   style="width:450px;height:280px;margin-left: 20px;margin-top: 10px"/>
        </dv-border-box8>
      </div>

      <div id="chart3" class="chart_items11">
        <dv-border-box1>
          <div>
            <Pie
              style="display: flex; justify-content: center; align-items: center;margin-top: 20px;margin-left: 5px"/>
            <!--            <dv-conical-column-chart :config="config2" style="width:400px;height:200px;" />-->
          </div>
        </dv-border-box1>
      </div>

      <div id="chart4" class="chart_items">
        <dv-border-box13>
          <div style="  background: linear-gradient(to right, #0D3DB6 0%, #052678 50%, #0C2542 100%);
  color: white;
  font-size: 18px;  margin-left: 25px;margin-top: 20px;margin-right:25px;text-align: center">商品库存预警
          </div>
          <dv-scroll-board :config="config"
                           style="width: 450px;height: 280px;margin-left: 25px;margin-right: 25px"/>
        </dv-border-box13>
      </div>
    </div>

    <div id="bottom" class="bottom-area">

      <div id="chart6" class="bottom_left_item">
        <div id="chart12" class="chart_item_bottom">
          <dv-border-box4>
            <div style="  background: linear-gradient(to right, #0D3DB6 0%, #052678 50%, #0C2542 100%);
  color: white;
  font-size: 18px;  margin-left: 50px;margin-top: 30px;margin-right:25px;text-align: center">
              近七日热门地区的销售金额(单位:元)
            </div>
            <div>
              <Line v-if="isload" id="main" :Data="line_data" style="margin-left: 0;margin-top: 30px"/>
            </div>
          </dv-border-box4>
        </div>

      </div>

      <div id="chart9" class="bottom_right_item">
        <div id="chart11" class="chart_item_bottom">
          <dv-border-box4 :reverse="true">
            <div style="  background: linear-gradient(to right, #0D3DB6 0%, #052678 50%, #0C2542 100%);
  color: white;
  font-size: 18px;  margin-left: 30px;margin-top: 10px;margin-right: 35px;text-align: center">
              热门关键字Top10
            </div>
            <dv-capsule-chart :config="config2"
                              style="width:42rem;height:25rem;margin-top: 10px;margin-right: 25px;margin-left: 25px"/>
          </dv-border-box4>
        </div>
      </div>


    </div>

  </div>


</template>
<style scoped>
@import "charts-view/css/energy_iml.css";
</style>
