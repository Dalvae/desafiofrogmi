<template>
  <div class="container mx-auto">
    <h1 class="text-2xl font-bold mb-4">Terremotos</h1>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
      <div
        v-for="earthquake in earthquakes"
        :key="earthquake.id"
        class="bg-white shadow-md p-4"
      >
        <h2 class="text-xl font-bold">{{ earthquake.attributes.title }}</h2>
        <p class="text-gray-600">
          Magnitud: {{ earthquake.attributes.magnitude }}
        </p>
        <p class="text-gray-600">
          Ubicación: {{ earthquake.attributes.place }}
        </p>
        <p class="text-gray-600">
          Fecha: {{ formatDate(earthquake.attributes.time) }}
        </p>

        <div class="mt-4">
          <h3 class="text-lg font-bold">Comentarios:</h3>
          <ul>
            <li
              v-for="comment in earthquake.comments"
              :key="comment.id"
              class="bg-gray-100 p-2 mb-2"
            >
              {{ comment.body }}
            </li>
          </ul>

          <form @submit.prevent="addComment(earthquake.id)">
            <textarea
              v-model="newComment"
              class="w-full border border-gray-300 p-2 mb-2"
              placeholder="Agregar comentario"
            ></textarea>
            <button type="submit" class="bg-blue-500 text-white px-4 py-2">
              Enviar
            </button>
          </form>
        </div>
      </div>
    </div>

    <div class="mt-4">
      <button
        @click="previousPage"
        :disabled="currentPage === 1"
        class="bg-gray-200 px-4 py-2 mr-2"
      >
        Anterior
      </button>
      <button
        @click="nextPage"
        :disabled="currentPage === totalPages"
        class="bg-gray-200 px-4 py-2"
      >
        Siguiente
      </button>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      earthquakes: [],
      currentPage: 1,
      totalPages: 1,
      newComment: "",
    };
  },
  methods: {
    async fetchEarthquakes() {
      console.log(`Requesting URL: /api/features?page=${this.currentPage}`);
      const response = await fetch(`/api/features?page=${this.currentPage}`);

      const data = await response.json();
      this.earthquakes = data.data;
      this.totalPages = data.pagination.total;
      console.log(this.earthquake);
    },
    formatDate(dateString) {
      const options = { year: "numeric", month: "long", day: "numeric" };
      return new Date(dateString).toLocaleDateString(undefined, options);
    },
    async addComment(earthquakeId) {
      const response = await fetch(`/api/features/${earthquakeId}/comments`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ body: this.newComment }),
      });

      if (response.ok) {
        this.newComment = "";
        this.fetchEarthquakes();
      }
    },
    previousPage() {
      if (this.currentPage > 1) {
        this.currentPage--;
        this.fetchEarthquakes();
      }
    },
    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.currentPage++;
        this.fetchEarthquakes();
      }
    },
  },
  created() {
    this.fetchEarthquakes();
  },
};
</script>
