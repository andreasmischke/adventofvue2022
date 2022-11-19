<script setup lang="ts">
import { reactive } from 'vue'

const X = 'x'
const O = 'o'

const state = reactive({
  field: [reactive([null, X, null]), reactive([null, O, null]), reactive([null, null, null])],
})

console.log('debug', state.field[2].value)
</script>

<template>
  <div class="w-full h-full flex justify-center items-center bg-red-500">
    <table>
      <tbody>
        <tr v-for="row in 3" :key="row">
          <td v-for="col in 3" :key="col" class="bg-slate-500">{{ state.field[row][col] }}: {{ row }}#{{ col }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
