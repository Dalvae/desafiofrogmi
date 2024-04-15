export default defineNuxtConfig({
  devServer: {
    port: 8080,
  },
  nitro: {
    devProxy: {
      "/api": {
        target: "http://backend:3000/api/",
        changeOrigin: true,
      },
    },
  },

  ssr: true,
});
