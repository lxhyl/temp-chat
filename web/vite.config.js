import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig((command, mode) => {
  console.log("vite mode",mode)
  return {
    base:'http://114.132.210.203/chat/',
    plugins: [vue()],
  }
})
