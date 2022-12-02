<template>
  <div class="w-full h-full grid place-content-center">
    <div v-if="question !== null" class="max-w-l w-full flex flex-col">
      <div data-qa="setup" class="md:w-3/4 m-4 text-teal-900 text-5xl self-start">
        {{ question.setup }}
      </div>
      <div data-qa="delivery" class="md:w-3/4 mt-2 m-4 text-red-900 self-end text-5xl text-right">
        {{ showDelivery ? question.delivery : '&nbsp;'}}
      </div>
      <button class="bg-green text-white col-span-1 rounded-lg py-2 hover:opacity-90 w-1/3 mx-auto mt-4"
        @click="handleClick">
        {{ showDelivery ? 'Another' : 'Tell Me!' }}
      </button>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from "vue";

/** @type {Ref<{ setup: string; delivery: string } | null>} */
const question = ref(null)
const showDelivery = ref(false)

const handleClick = () => {
  if (!showDelivery.value) {
    showDelivery.value = true;
    return
  }

  question.value = null
  showDelivery.value = false
  loadJoke()
}

const loadJoke = async () => {
  const json = await fetch('https://v2.jokeapi.dev/joke/christmas').then(res => res.json())

  question.value = {
    delivery: json.delivery,
    setup: json.setup,
  }
}

onMounted(loadJoke)
</script>
