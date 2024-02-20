<template>
    <div>
        <Modal :show="confirmingUserDeletion" @close="closeModal">
            <div class="p-6">
                <h2 class="text-lg font-medium text-gray-900 dark:text-gray-100">
                    Are you sure you want to delete this data?
                </h2>

                <div class="mt-6 flex justify-end">
                    <SecondaryButton @click="closeModalDelete"> Cancel </SecondaryButton>

                    <DangerButton
                        class="ms-3"
                        :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                        @click="deleteData()"
                    >
                        Delete
                    </DangerButton>
                </div>
            </div>
        </Modal>
        <Modal :show="openingModal" @close="closeModal" :isUpdate=false>
            <div class="p-6">
                <h1 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight" v-show="!isUpdate">Create Delivery</h1>
                <h1 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight" v-show="isUpdate">Detail Delivery</h1>
                <br>
                <hr style="height:3px;color:black;background-color:black">
                <div class="mt-6">
                    <InputLabel for="order_date" value="Tanggal Order" />

                    <TextInput
                        type="text"
                        class="mt-1 block w-full"
                        v-model="orders.order_date"
                        autofocus
                        :disabled="isUpdate"
                    />

                    <InputError class="mt-2" :message="form.errors.order_date" />
                </div>

                <br>
                <h1 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">Detail Produk</h1>
                <br>
                <hr style="height:3px;color:black;background-color:black">

                <div class="mt-6" v-show="!isUpdate">
                    <InputLabel for="product_name" value="Produk" />

                    <select class="form-select mt-1 block w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm" 
                        v-model="products.product_name" autofocus required :disabled="isUpdate">
                        <option v-for="item in products.data">{{ item.product_name }}</option>
                    </select>

                    <InputError class="mt-2" :message="form.errors.product_name" />
                </div>

                <div class="mt-6" v-show="!isUpdate">
                    <InputLabel for="amount" value="Jumlah" />

                    <NumberInput
                        type="number"
                        class="mt-1 block w-full"
                        v-model="products.amount"
                        required
                        autofocus
                        :disabled="isUpdate"
                    />

                    <InputError class="mt-2" :message="form.errors.amount" />
                </div>

                <div class="mt-6 mb-6 flex justify-end">
                    <SecondaryButton @click="insertData()" v-show="!isUpdate"> Add </SecondaryButton>
                </div>

                <table class="min-w-full border divide-y divide-gray-200">
                    <thead>
                    <tr>
                        <th class="bg-gray-50 px-6 py-3 text-left">
                            <span class="text-xs font-medium uppercase leading-4 tracking-wider text-gray-500">Produk</span>
                        </th>
                        <th class="bg-gray-50 px-6 py-3 text-left">
                            <span class="text-xs font-medium uppercase leading-4 tracking-wider text-gray-500">Jumlah</span>
                        </th>
                    </tr>
                    </thead>

                    <tbody class="bg-white divide-y divide-gray-200 divide-solid">
                        <tr class="bg-white" v-for="(item, index) in orders.order_details" :key="index">
                            <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                                {{ item.product_name }}
                            </td>
                            <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                                {{ item.amount.toLocaleString('id') }}
                            </td>
                        </tr>
                    </tbody>
                </table>

                <hr style="height:3px;color:black;background-color:black">

                <div class="mt-6 flex justify-end">
                    <SecondaryButton @click="storeData()" v-show="!isUpdate"> Save </SecondaryButton>
                </div>
            </div>
        </Modal>
        <div class="min-h-screen bg-gray-100 dark:bg-gray-900">
            <nav class="bg-white dark:bg-gray-800 border-b border-gray-100 dark:border-gray-700">
                <!-- Primary Navigation Menu -->
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex justify-between h-16">
                        <div class="flex">
                            <!-- Logo -->
                            <div class="shrink-0 flex items-center">
                                <Link :href="route('staffDashboard')">
                                    <ApplicationLogo
                                        class="block h-9 w-auto fill-current text-gray-800 dark:text-gray-200"
                                    />
                                </Link>
                            </div>

                            <!-- Navigation Links -->
                            <div class="hidden space-x-8 sm:-my-px sm:ms-10 sm:flex">
                                <NavLink :href="route('staffDashboard')" :active="route().current('staffDashboard')">
                                    Dashboard
                                </NavLink>
                                <NavLink :href="route('staffProduct')" :active="route().current('staffProduct')">
                                    Products
                                </NavLink>
                                <NavLink :href="route('staffDelivery')" :active="route().current('staffDelivery')">
                                    Delivery
                                </NavLink>
                            </div>
                        </div>

                        <div class="hidden sm:flex sm:items-center sm:ms-6">
                            <!-- Settings Dropdown -->
                            <div class="ms-3 relative">
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <span class="inline-flex rounded-md">
                                            <button
                                                type="button"
                                                class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 dark:text-gray-400 bg-white dark:bg-gray-800 hover:text-gray-700 dark:hover:text-gray-300 focus:outline-none transition ease-in-out duration-150"
                                            >
                                                {{ $page.props.auth.user.name }}

                                                <svg
                                                    class="ms-2 -me-0.5 h-4 w-4"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    viewBox="0 0 20 20"
                                                    fill="currentColor"
                                                >
                                                    <path
                                                        fill-rule="evenodd"
                                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                        clip-rule="evenodd"
                                                    />
                                                </svg>
                                            </button>
                                        </span>
                                    </template>

                                    <template #content>
                                        <DropdownLink :href="route('profile.edit')"> Profile </DropdownLink>
                                        <DropdownLink :href="route('logout')" method="post" as="button">
                                            Log Out
                                        </DropdownLink>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>

                        <!-- Hamburger -->
                        <div class="-me-2 flex items-center sm:hidden">
                            <button
                                @click="showingNavigationDropdown = !showingNavigationDropdown"
                                class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 dark:text-gray-500 hover:text-gray-500 dark:hover:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-900 focus:outline-none focus:bg-gray-100 dark:focus:bg-gray-900 focus:text-gray-500 dark:focus:text-gray-400 transition duration-150 ease-in-out"
                            >
                                <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                                    <path
                                        :class="{
                                            hidden: showingNavigationDropdown,
                                            'inline-flex': !showingNavigationDropdown,
                                        }"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M4 6h16M4 12h16M4 18h16"
                                    />
                                    <path
                                        :class="{
                                            hidden: !showingNavigationDropdown,
                                            'inline-flex': showingNavigationDropdown,
                                        }"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M6 18L18 6M6 6l12 12"
                                    />
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Responsive Navigation Menu -->
                <div
                    :class="{ block: showingNavigationDropdown, hidden: !showingNavigationDropdown }"
                    class="sm:hidden"
                >
                    <div class="pt-2 pb-3 space-y-1">
                        <ResponsiveNavLink :href="route('dashboard')" :active="route().current('dashboard')">
                            Dashboard
                        </ResponsiveNavLink>
                    </div>

                    <!-- Responsive Settings Options -->
                    <div class="pt-4 pb-1 border-t border-gray-200 dark:border-gray-600">
                        <div class="px-4">
                            <div class="font-medium text-base text-gray-800 dark:text-gray-200">
                                {{ $page.props.auth.user.name }}
                            </div>
                            <div class="font-medium text-sm text-gray-500">{{ $page.props.auth.user.email }}</div>
                        </div>

                        <div class="mt-3 space-y-1">
                            <ResponsiveNavLink :href="route('profile.edit')"> Profile </ResponsiveNavLink>
                            <ResponsiveNavLink :href="route('logout')" method="post" as="button">
                                Log Out
                            </ResponsiveNavLink>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- Page Heading -->
            <header class="bg-white dark:bg-gray-800 shadow" v-if="$slots.header">
                <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                    <slot name="header" />
                </div>
            </header>

            <!-- Page Content -->
            <main>
                <div class="py-10">
                    <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
                        <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                            <div class="overflow-hidden overflow-x-auto border-b border-gray-200 bg-white p-6">

                                <PrimaryButton @click="openModal">Create</PrimaryButton>
                                <br>
                                <br>
                                <div class="min-w-full align-middle">
                                    <table class="min-w-full border divide-y divide-gray-200">
                                        <thead>
                                        <tr>
                                            <th class="bg-gray-50 px-6 py-3 text-left">
                                                <span class="text-xs font-medium uppercase leading-4 tracking-wider text-gray-500">Order ID</span>
                                            </th>
                                            <th class="bg-gray-50 px-6 py-3 text-left">
                                                <span class="text-xs font-medium uppercase leading-4 tracking-wider text-gray-500">Order Date</span>
                                            </th>
                                            <th class="bg-gray-50 px-6 py-3 text-left">
                                                <span class="text-xs font-medium uppercase leading-4 tracking-wider text-gray-500">Order Status</span>
                                            </th>
                                            <!-- <th class="w-56 bg-gray-50 px-6 py-3 text-left">
                                            </th> -->
                                        </tr>
                                        </thead>
            
                                        <tbody class="bg-white divide-y divide-gray-200 divide-solid">
                                            <tr class="bg-white" v-for="(item, index) in orders.data" :key="index">
                                                <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                                                    {{ item.id }}
                                                </td>
                                                <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                                                    {{ item.order_date }}
                                                </td>
                                                <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                                                    {{ item.order_status }}
                                                </td>
                                                <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                                                    <PrimaryButton @click="openModalShow(item)">View</PrimaryButton>
                                                    <DangerButton @click="openModalDelete(item)">Delete</DangerButton>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br>
                                    <TailwindPagination
                                        :data="orders"
                                        @pagination-change-page="getResults"
                                    />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</template>

<script setup>
import { nextTick, ref } from 'vue';
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import Dropdown from '@/Components/Dropdown.vue';
import DropdownLink from '@/Components/DropdownLink.vue';
import NavLink from '@/Components/NavLink.vue';
import ResponsiveNavLink from '@/Components/ResponsiveNavLink.vue';
import DangerButton from '@/Components/DangerButton.vue';
import Modal from '@/Components/Modal.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import SecondaryButton from '@/Components/SecondaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import NumberInput from '@/Components/NumberInput.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import { Link, useForm } from '@inertiajs/vue3';
import { TailwindPagination } from 'laravel-vue-pagination';

const showingNavigationDropdown = ref(false);

const form = useForm({

});
</script>

<script>
import axios from 'axios';
import {useToast} from 'vue-toast-notification';
import 'vue-toast-notification/dist/theme-sugar.css';

const $toast = useToast();

const openingModal = ref(false);

const confirmingUserDeletion = ref(false);

export default {
    name: 'deliveryList',
    data() {
        return {
            'url': 'http://localhost:8000/api/delivery',
            'orders': {
                'order_date': '',
                'order_details': [],
                'order_status': ''
            },
            'products': {
                'product_id': '',
                'product_name': '',
                'amount': 0
            },
            'detail_data': [],
            'isUpdate': false
        }
    },
    created() {
        this.getData();
        this.getPaketData();
    },
    methods: {
        openModal() {
            openingModal.value = true;
            this.orders.order_date = '';
            this.isUpdate = false;
        },

        async openModalShow(item) {
            openingModal.value = true;
            this.isUpdate = true;
            this.orders.order_details = [];
            await axios.get(this.url + '/' + item.id).then(response => {
                this.orders.order_date = response.data.order_date;
                this.orders.order_details.push({
                    product_name: response.data.order_details['product_name'],
                    amount: response.data.order_details['amount_out'],
                });
            }).catch(error => {
                console.log(error);
            });
        },

        openModalDelete(item) {
            confirmingUserDeletion.value = true;
            this.orders.product_id = item.id;
            this.isUpdate = true;
        },

        closeModal() {
            openingModal.value = false;
            this.orders.order_date = '';
            this.detail_data = [];
        },

        closeModalDelete() {
            confirmingUserDeletion.value = false;
            this.orders.order_date = '';
            this.orders.product_initial_stock = 0;
        },

        async getData() {
            await axios.get(this.url).then(response => {
                this.orders = response.data.data;
            }).catch(error => {
                console.log(error);
            });
        },

        async getPaketData() {
            await axios.get('http://localhost:8000/api/product').then(response => {
                this.products = response.data.data;
            }).catch(error => {
                console.log(error);
            });
        },

        async getProductData() {
            await axios.get('http://localhost:8000/api/productData').then(response => {
                this.productData = response.data.data;
            }).catch(error => {
                console.log(error);
            });
        },

        async storeData() {
            let formData = new FormData();
            
            this.orders.order_details.forEach((value) => {
                formData.append("order_details", JSON.stringify(this.orders.order_details));
            });

            formData.append('order_date', this.orders.order_date);

            await axios.post(this.url, formData).then(response => {
                if(response.status == 201) {
                    openingModal.value = false;
                    this.$toast.success('Data Created Successfully', {
                        position: 'top-right'
                    });
                    this.getData();
                }
            }).catch(error => {
                console.log(error);
            });
        },

        async showData() {
            this.orders.order_details = [];
            for(let i=0; i < this.orders.data.length; i++) {
                await axios.get(this.url + '/' + this.orders.data[i].id).then(response => {
                    this.detail_data.push({
                        product_name: response.data.order_details['product_name'],
                        amount: response.data.order_details['amount_out']
                    });
                }).catch(error => {
                    console.log(error);
                });
            }
        },

        async deleteData() {
            await axios.delete(this.url + '/' + this.orders.product_id).then(response => {
                this.$toast.success('Data Deleted Successfully', {
                    position: 'top-right'
                });
                confirmingUserDeletion.value = false;
                this.getData();
            }).catch(error => {
                console.log(error);
            });
        },

        async getResults(page = 1) {
            await axios.get(this.url + `?page=${page}`).then(response => {
                this.orders = response.data.data;
            }).catch(error => {
                console.log(error);
            });
        },

        onInitStockChange() {
            document.getElementById('product_stock').value = document.getElementById('product_initial_stock').value;
            this.orders.product_stock = document.getElementById('product_initial_stock').value;
        },

        insertData() {
            this.detail_data.push({
                product_name: this.products.product_name, 
                amount: this.products.amount
            });
            this.products.product_name =  '';
            this.products.amount = 0;
            this.orders.order_details = this.detail_data;
        }
    }
}
</script>
