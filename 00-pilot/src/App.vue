<script setup lang="ts">
import { computed, ref } from 'vue'

const X = '✕'
const O = '⃝'
type Player = typeof X | typeof O
const nextPlayer = ref<Player>(Math.random() > 0.5 ? O : X)

type Field = Player | null
type Board = [Field, Field, Field, Field, Field, Field, Field, Field, Field]
const createEmptyField = (): Board => [null, null, null, null, null, null, null, null, null]
const board = ref<Board>(createEmptyField())
const restart = () => {
  board.value = createEmptyField()
}

type GameStatus = 'open' | 'draw' | Player
const winningLines: [number, number, number][] = [
  [0, 1, 2], // top row
  [3, 4, 5], // middle row
  [6, 7, 8], // bottom row
  [0, 3, 6], // left column
  [1, 4, 7], // middle column
  [2, 5, 8], // right column
  [0, 4, 8], // diagonal top left to bottom right
  [2, 4, 6], // diagonal top right to bottom left
]
const gameStatus = computed<GameStatus>(() => {
  for (const line of winningLines) {
    if (
      board.value[line[0]] !== null &&
      board.value[line[0]] === board.value[line[1]] &&
      board.value[line[0]] === board.value[line[2]]
    ) {
      return board.value[line[0]] as Player
    }
  }

  if (board.value.every(x => x !== null)) {
    return 'draw'
  }

  return 'open'
})
const textStatus = computed(() => {
  switch (gameStatus.value) {
    case 'open':
      return `It's ${nextPlayer.value}'s turn`
    case 'draw':
      return "It's a draw!"
    default:
      return `${gameStatus.value} has won!`
  }
})

const playField = (offset: number) => {
  if (board.value[offset] !== null || gameStatus.value !== 'open') {
    return
  }

  board.value[offset] = nextPlayer.value
  nextPlayer.value = nextPlayer.value === X ? O : X
}
</script>

<template>
  <div class="w-full h-full flex flex-col justify-center items-center">
    <div class="grid gap-0.5 grid-cols-3 grid-rows-3 bg-gray-dark">
      <div
        @click="() => playField(field - 1)"
        v-for="field in 9"
        :key="field"
        class="w-32 h-32 flex justify-center items-center bg-white text-5xl"
        :class="{
          'text-white': board[field - 1] === null,
          'cursor-default': board[field - 1] !== null || gameStatus !== 'open',
          'hover:bg-gray-light cursor-pointer': board[field - 1] === null && gameStatus === 'open',
        }"
      >
        {{ board[field - 1] ?? nextPlayer }}
      </div>
    </div>
    <div class="my-10 text-3xl font-light">{{ textStatus }}</div>
    <div class="h-14">
      <button v-if="gameStatus !== 'open'" class="bg-green p-3 rounded-lg text-2xl" @click="restart">Play again</button>
    </div>
  </div>
</template>
