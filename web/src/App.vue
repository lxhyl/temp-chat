<template>
  <div class="contianer">
    <p style="text-align: center; color: rgb(99, 180, 71)">{{ roomid }}</p>
    <div class="msg-box">
      <p
        class="animate__animated animate__zoomInUp"
        v-for="(item, index) in msg"
        :key="index"
        style="white-space: pre-wrap;"
      >{{ item }}</p>
      <p class="input-box">
        <span>[{{ nowTime }}@{{ username }}]#&nbsp;</span>
        <input ref="input" @keyup.enter="sendMsg" @blur="onblur" />
      </p>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted, nextTick } from "vue";
import format from "./utils/date";

function getQueryString(name) {
  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
  var r = window.location.search.substr(1).match(reg);
  if (r != null) {
    return unescape(r[2]);
  }
  return null;
}

const msg = ref([]);

let roomid = getQueryString('room');
console.log("roomid", roomid);
if (!roomid) {
  roomid = 'lxhyl'
  msg.value.push(`You didn't join any rooms.There are default room.add room name behind url to join. 
         eg. join room 'lxhyl':
          114.132.210.203/chat?room=lxhyl
  `);
}
let username = ref("");

// const socket = new WebSocket("ws://localhost:5002");
const socket = new WebSocket("ws://114.132.210.203:5002")
socket.addEventListener("open", function (event) { });

// Listen for messages
socket.addEventListener("message", function (event) {
  const rcvMsg = JSON.parse(event.data || null);
  console.log("rcvMsg", rcvMsg);
  if (rcvMsg.roomid === roomid && username.value !== rcvMsg.from) {
    msg.value.push(`[${format(rcvMsg.date)}@${rcvMsg.from}]# ${rcvMsg.data}`);
  }
});

const sendMsg = (e) => {
  const type = "text",
    from = username.value,
    date = Date.now(),
    data = e.target.value;
  if (!data) return;
  const msgStr = `[${format(date)}@${from}]# ${data}`;
  msg.value.push(msgStr);
  e.target.scrollIntoView();
  e.target.value = "";

  const message = {
    roomid: roomid,
    type,
    data,
    from,
    date,
  };
  console.log(message);
  socket.send(JSON.stringify(message));
};

let nowTime = ref("");
let timer = setInterval(() => {
  const date = format(Date.now());
  nowTime.value = date;
}, 1000);

const input = ref(null);
function onblur(e) {
  e.target.focus();
}

onMounted(() => {
  nextTick(() => {
    input.value.focus();
  });
});

onMounted(() => {
  const lcUsername = localStorage.getItem("username");
  if (!lcUsername) {
    const name =  prompt("怎么称呼你？", "")
    console.log("name",name)
    username.value = name
    localStorage.setItem("username", username.value);
  }else{
  console.log("lcUsername",lcUsername)
  username.value = lcUsername
  }
  msg.value.push(`Welcome, ${username.value}`);
});
</script>
<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: rgb(197, 197, 197);
  width: 100%;
  height: 100%;
  position: absolute;
  margin: 0;
  padding: 0;
  background-color: rgb(30, 30, 30);
}
.contianer {
  position: absolute;
  width: 96%;
  height: 80%;
  left: 0;
  top: 0;
  right: 0;
  bottom: 0;
  margin: auto;
  text-align: left;
  border: 1px dashed rgb(197, 197, 197);
  padding: 5px;
  overflow: auto;
  font-size: 12px;
}
.msg-box {
  padding-bottom: 20px;
}
.msg-box > p {
  margin: 0;
}
.input-box {
  display: inline-flex;
  width: 100%;
}
input {
  flex: 1;
  border: none;
  background-color: rgb(30, 30, 30);
  outline: none;
  color: rgb(99, 180, 71);
}
</style>
