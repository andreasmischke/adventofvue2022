<script setup>
import { computed } from "vue";
import CountdownHeader from '@/components/CountdownHeader.vue'
import CountdownSegment from './components/CountdownSegment.vue'
import { useNow } from '@vueuse/core'

const now = useNow({ interval: 1000 })
const christmas = new Date('12/25/2022 00:00:00')

const diff = computed(() => {
  let seconds = Math.floor((christmas.getTime() - now.value.getTime()) / 1000)

  const days = Math.floor(seconds / 86400)
  seconds -= days * 86400

  const hours = Math.floor(seconds / 3600)
  seconds -= hours * 3600

  const minutes = Math.floor(seconds / 60)
  seconds -= minutes * 60

  return [days, hours, minutes, seconds]
})
</script>
<template>
  <div class="w-full h-full flex justify-center items-center p-10">
    <div>
      <div class="shadow-md relative bg-white p-5 rounded-lg border-gray-100 border-[1px]">
        <CountdownHeader />
        <main class="flex justify-center">
          <CountdownSegment label="days" :number="diff[0]" />
          <CountdownSegment label="hours" :number="diff[1]" />
          <CountdownSegment label="minutes" :number="diff[2]" />
          <CountdownSegment label="seconds" :number="diff[3]" />
        </main>
      </div>
      <h4 class="mt-10 text-gray-400 text-center text-sm">
        This challenge brought to you by <a href="https://vueschool.io/" class="underline">Vue School</a>
      </h4>
    </div>
  </div>
</template>

<style>
div {
  display: block;
}

body {
  @apply bg-gray-100;
}
</style>
