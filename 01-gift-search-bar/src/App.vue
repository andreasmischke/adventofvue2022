<script setup>
import { ref, watch } from 'vue'

const loading = ref(false)
const searchTerm = ref('')
const results = ref([])

const debounce = (fn, delay) => {
  let timeout;

  return (...args) => {
    clearTimeout(timeout);
    timeout = setTimeout(() => fn(...args), delay)
  }
}

const findProducts = debounce(async term => {
  if (term === '') {
    results.value = []
    return
  }

  loading.value = true
  const res = await fetch(`https://dummyjson.com/products/search?q=${term}`)
  const json = await res.json()

  results.value = json.products

  loading.value = false
}, 300)

watch(searchTerm, newTerm => findProducts(newTerm))
</script>

<template>
  <div class="w-full h-full flex flex-col gap-5 justify-center items-center">
    <h1 class="text-4xl font-bold">Gift Search Bar</h1>
    <input type="text" class="p-2 border-2 border-gray-dark" v-model="searchTerm" placeholder="Start typing..." />
    <div class="h-80">
      <span v-if="loading">Please wait...</span>
      <ul v-else class="list-disc">
        <li v-for="result in results" :key="result.id">{{ result.title }}</li>
      </ul>
    </div>
  </div>
</template>
