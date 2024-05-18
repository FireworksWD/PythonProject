<script setup lang="ts">
import {
  ElAvatar,
  ElButton,
  ElCol,
  ElIcon,
  ElMenu,
  ElMenuItem,
  ElMenuItemGroup,
  ElRow,
  ElScrollbar
} from 'element-plus'
import {nextTick, onMounted, ref, watch} from 'vue';
import dayjs from "dayjs";
import {useUserStore} from "@/store/modules/user";
import {getHistoryMsgUserListAPI, getMsgUserListAPI} from './apis/message.api'
import {StarFilled, ChatLineRound, Avatar} from '@element-plus/icons-vue'
import {base_img_url} from "@/main";

const userStore = useUserStore();
const userList = ref()
const thisUser = ref()
const isSend = ref(true)
watch(thisUser, (newValue) => {
  isSend.value = !newValue;
});
const handleSelectUser = async (val) => {
  thisUser.value = val
  const res = await getHistoryMsgUserListAPI(thisUser.value)
  MsgList.value = []
  res.forEach(item => {
    //头部添加
    MsgList.value.unshift(item);
  });
  scrollToBottom()
  // MsgList.value.push(res)
  // console.log(MsgList.value)
}
setTimeout(async () => {
  userList.value = await getMsgUserListAPI()
}, 500)

let ws = new WebSocket('ws://localhost:8088/ws/' + userStore.getUserInfo.username)
onMounted(() => {
  console.log('WebSocket readyState:', ws.readyState);
  ws.addEventListener('open', handlewsOpen, false);
  ws.addEventListener('close', handlewsClose, false);
  ws.addEventListener('error', handlewsError, false);
  ws.addEventListener('message', handlewsMessage, false);
// 拉取本地聊天记录
// getRecord();
//   chatRoom.value = document.querySelector('.chat-room');
//   console.log('chatRoom', chatRoom.value);
});
const handlewsOpen = (e) => {
  message.value = "在线中"
}
const handlewsClose = (e) => {
  console.error('WebSocket closed:', e);
  message.value = "连接关闭,请刷新重试!";
}
const handlewsError = (e) => {
  message.value = "连接错误,请刷新重试或者检查网络!";
  console.error('WebSocket error:', e);
}
const handlewsMessage = async (e) => {
  let data = JSON.parse(e.data);
  console.log(JSON.parse(data.text))
  const res = JSON.parse(data.text)
  if (res.type === 'SEND_MESSAGE') {
    MsgList.value.push(res.data)
  }
}
//重新连接
const reconnect = () => {
  ws.close()
  if (ws.readyState !== WebSocket.OPEN) {
    ws = new WebSocket('ws://localhost:8088/ws/' + userStore.getUserInfo.username)
  } else {
    return;
  }
  ws.addEventListener('open', handlewsOpen, false);
  ws.addEventListener('close', handlewsClose, false);
  ws.addEventListener('error', handlewsError, false);
  ws.addEventListener('message', handlewsMessage, false);
}
const message = ref()
//获取当前用户信息
const username = userStore.getUserInfo.username
const user_id = userStore.getUserInfo.id
const avatar = userStore.getUserInfo.avatar
const avatars = userStore.getUserInfo.avatars
const nickname = userStore.getUserInfo.name
console.log(userStore.getUserInfo)
console.log(username, user_id, nickname)
//聊天记录
const MsgList = ref([])
// 确保聊天室滚动到底部
const innerRef = ref()
const scrollbarRef = ref()

//移动到最底部
const scrollToBottom = () => {
  nextTick(() => {
    const innerRef = scrollbarRef.value.$el.querySelector('.message-container:last-child');
    if (innerRef) {
      innerRef.scrollIntoView({behavior: 'smooth', block: 'end'});
    }
  })
};
// const ws = new WebSocket("ws://159.75.18.63:9000");
// const ws = new WebSocket("ws://127.0.0.1:9000/ws");
const currentMsg = ref()
// let x = new Date().getTime()
// console.log(x, dayjs(parseInt(x.toString())).format('YYYY-MM-DD HH:mm:ss'))
const handleSendBtnClick = () => {
  let obj = {
    uid: user_id,
    username: username,
    dateTime: new Date().getTime(),
    text: currentMsg.value,
    token: userStore.getToken,
    receive_user: thisUser.value,
    img:base_img_url + avatars
  };
  ws.send(JSON.stringify({
    type: 'SEND_MESSAGE',
    data: obj,
  }))
  MsgList.value.push(obj)
  currentMsg.value = ''
  scrollToBottom()
//最顶部  box.scrollTo(0,  box.clientHeight -box.scrollHeight);
}
</script>

<template>
  <div>
    <el-container style="height: 700px">
      <el-aside>
        <el-scrollbar>
          <el-menu background-color="#545c64"
                   text-color="#fff"
                   active-text-color="#ffd04b">
            <el-sub-menu index="1">
              <template #title>
                <el-icon>
                  <ChatLineRound/>
                </el-icon>
                消息列表
              </template>
              <el-menu-item-group v-for="Item in userList" :key="Item.username">
                <el-menu-item :index="String(Item.username)" @click="handleSelectUser(Item.username)"
                              style="height: 40px;">
                  <template #title>
                    <el-icon>
                      <Avatar/>
                    </el-icon>
                    {{ Item.username }}
                  </template>
                </el-menu-item>
              </el-menu-item-group>
            </el-sub-menu>
          </el-menu>
        </el-scrollbar>
      </el-aside>

      <el-container>
        <el-header style="text-align: right; font-size: 12px; color: #544e4e; padding: 10px;">
          <el-row type="flex" align="middle" justify="space-between">
            <el-col :span="14">
              <div class="customer-name" style="font-size: 18px; font-weight: bold; text-align: center;">
                {{ thisUser }}
              </div>
            </el-col>

            <el-col :span="10">
              <div class="toolbar" style="display: flex; align-items: center;">
                <el-text class="mx-1" type="primary" style="margin-right: 10px;">
                  {{ message }}
                </el-text>
                <ElButton type="primary" style="margin-right: 10px;" @click="reconnect()">
                  重新连接
                </ElButton>

<!--                <el-dropdown>-->
<!--                  <el-icon style="margin-right: 10px; margin-top: 1px" size="25px">-->
<!--                    <setting/>-->
<!--                  </el-icon>-->
<!--                  <template #dropdown>-->
<!--                    <el-dropdown-menu>-->
<!--                      <el-dropdown-item>View</el-dropdown-item>-->
<!--                      <el-dropdown-item>Add</el-dropdown-item>-->
<!--                      <el-dropdown-item>Delete</el-dropdown-item>-->
<!--                    </el-dropdown-menu>-->
<!--                  </template>-->
<!--                </el-dropdown>-->

                <div class="user-info" style="margin-left: 10px; display: flex; align-items: center;">
                  <el-tag size="large">{{ username }}</el-tag>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <el-avatar size="default" fit="fit" v-if="avatar" :src="base_img_url+avatars"> {{
                      username
                    }}
                  </el-avatar>
                  <el-avatar size="default" fit="fit" v-else> {{ username }}</el-avatar>
                </div>
              </div>
            </el-col>
          </el-row>
        </el-header>


        <el-main style="margin-top: 1px; overflow-y: hidden;background-color: #ffffff">
          <el-scrollbar class="chat-room" ref="scrollbarRef" style="margin-top: 10px;">

            <div v-for="item in MsgList" :key="item.uid" ref="innerRef"
                 class="message-container">
              <!-- 左边 -->
              <div v-if="user_id !== item.uid" style="margin-left: 10px;margin-bottom: 8px;">
                <el-row class="row-bg" type="flex" align="middle">
                  <el-avatar size="default" fit="fit" :src="item.img">{{ item.username }}</el-avatar>
                  <span style="margin-left: 10px">{{
                      dayjs(parseInt(item.dateTime)).format('YYYY-MM-DD HH:mm:ss')
                    }}</span>
                </el-row>

                <el-row>
                  <el-col :span="1000" :offset="1" class="msg">
                    {{ item.text }}
                  </el-col>
                </el-row>
              </div>
              <!-- 右边 -->
              <div v-else style="margin-right: 10px;margin-bottom: 8px;">
                <el-row class="row-bg" type="flex" justify="end" align="middle">
                                <span style="margin-right: 10px">{{
                                    dayjs(parseInt(item.dateTime)).format('YYYY-MM-DD HH:mm:ss')
                                  }}</span>

                  <el-avatar size="default" fit="fit" v-if="avatar" :src="base_img_url+avatars"> {{
                      username
                    }}
                  </el-avatar>
                  <el-avatar size="default" fit="fit" v-else> {{ username }}</el-avatar>
                </el-row>

                <el-row justify="end">
                  <el-col :span="1000" class="msg2" style="margin-right: 20px;">
                    {{ item.text }}
                  </el-col>
                </el-row>
              </div>
              <el-divider>
                <el-icon>
                  <star-filled/>
                </el-icon>
              </el-divider>
            </div>

          </el-scrollbar>

        </el-main>
        <el-row class="row-bg" type="flex" justify="space-around" align="middle">
          <el-col :span="20">
            <el-input type="text" class="search-input" autofocus
                      @keyup.enter="handleSendBtnClick"
                      placeholder="请输入消息按Enter发送" v-model="currentMsg"></el-input>
          </el-col>
          <el-col :span="2">
            <el-button :disabled="isSend" id="searchBtn" @click="handleSendBtnClick"
                       type="primary" size="default">
              发送
            </el-button>
          </el-col>
        </el-row>
      </el-container>
    </el-container>
  </div>
</template>
<style scoped>
.el-aside {
  width: 210px;
  padding: 20px;
  background-color: #545c64
}

.el-header {
  padding: 20px;
}

.search-input {
  flex-grow: 1; /* 允许输入框占据更多空间 */
  margin-right: 80px; /* 给按钮留出空间 */
}

#searchBtn {
  color: white;
  background-color: #767dff;
  transition: background-color 1s; /* 添加过渡效果 */
}

.message-container {
  margin-top: 10px;
  margin-bottom: 20px;
}

.layout-container-demo .el-header {
  position: relative;
  /* background-color: var(--el-color-primary-light-7); */
  color: var(--el-text-color-primary);
}

.layout-container-demo .el-aside {
  color: var(--el-text-color-primary);
  /* background: var(--el-color-primary-light-8); */
}

.layout-container-demo .el-menu {
  border-right: none;
}

.layout-container-demo .el-main {
  padding: 0;
}

.layout-container-demo .toolbar {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  right: 5px;
}

.chat-room .msg {
  background-color: #12B7F5;
  /* box-shadow: rgba(18, 23, 45, 0.6) 0px 8px 24px; */
  border-radius: 4px;
  padding: 10px;
  font-size: 18px;
  line-height: 16px;
  /* width: auto; */
  /* max-width: 330px; */
  margin-top: 20px;
  color: white;
}

.msg2 {
  background-color: #12B7F5;
  /* box-shadow: rgba(18, 23, 45, 0.6) 0px 8px 24px; */
  border-radius: 4px;
  padding: 10px;
  font-size: 18px;
  line-height: 16px;
  /* width: auto; */
  /* max-width: 330px; */
  margin-top: 20px;
  color: white;
}
</style>
