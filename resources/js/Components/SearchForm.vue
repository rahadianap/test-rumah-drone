<script setup>
import { defineEmits } from "vue";

const emit = defineEmits(['search']);

const search = (e) => {
    emit('search', e.target.value);
};

</script>

<template>
    <form class="py-3 flex items-center">
        <label class="sr-only">Search</label>
        <div class="relative w-full">
            <input
                class="border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm"
                v-model="model"
                ref="input"
                @input="search"
            />
        </div>
    </form>
</template>