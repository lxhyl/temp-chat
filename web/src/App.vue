<template>
  <ul class="test">
    <li v-for="(item,index) in msg" :key="index">
      {{item}}
    </li>
  </ul>
</template>
<script setup>
import {ref,onMounted} from "vue";
const msg = ref(['1'])
const socket = new WebSocket('ws://localhost:5002');
socket.addEventListener('open', function (event) {
    socket.send('Hello Server!');
});

// Listen for messages
socket.addEventListener('message', function (event) {
    console.log('Message from server ', event.data);
});

</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
.test{
  width: 40%;
  margin: auto;
  text-align: left;
}
</style>
