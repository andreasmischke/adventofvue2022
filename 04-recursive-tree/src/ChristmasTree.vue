<template>
  <div>
    <ChristmasTree v-if="(props.size > 1)" :size="(props.size - 1)" />
    <div class="flex flex-row justify-center">
      <div v-for="i in props.size" class="relative rounded-full bg-green w-16 h-16 -m-2 flex justify-center items-center" />
    </div>
  </div>
</template>

<script setup lang="ts">
const props = withDefaults(
  defineProps<{
    size: number
  }>(),
  {
    size: 1,
  }
)
</script>
