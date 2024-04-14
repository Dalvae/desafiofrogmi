export default defineNuxtConfig({
  devServer: {
    port: 8080 // default: 3000
  },
  vite: {
    server: {
      proxy: {
        '/api': {
          target: 'http://backend:3000/api',
          changeOrigin: true,
          rewrite: path => path.replace(/^\/api/, '')
        }
      }
    }
  }
})
