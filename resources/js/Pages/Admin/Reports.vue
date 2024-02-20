<template>
    <div>
        <Modal :show="confirmingUserDeletion" @close="closeModal">
            <div class="p-6">
                <h2 class="text-lg font-medium text-gray-900 dark:text-gray-100">
                    Are you sure you want to delete your account?
                </h2>

                <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
                    Once your account is deleted, all of its resources and data will be permanently deleted. Please
                    enter your password to confirm you would like to permanently delete your account.
                </p>

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
                <h1 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight" v-show="!isUpdate">Create Report</h1>
                <h1 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight" v-show="isUpdate">Edit Report</h1>
                <br>
                <hr style="height:3px;color:black;background-color:black">
                <div class="mt-6">
                    <InputLabel for="report_name" value="Nama Report" />

                    <TextInput
                        type="text"
                        class="mt-1 block w-full"
                        v-model="packages.report_name"
                        required
                        autofocus
                    />

                    <InputError class="mt-2" :message="form.errors.report_name" />
                </div>

                <div class="mt-6">
                    <InputLabel for="report_view" value="View Path" />

                    <TextInput
                        type="text"
                        class="mt-1 block w-full"
                        v-model="packages.report_view"
                        required
                        autofocus
                    />

                    <InputError class="mt-2" :message="form.errors.report_view" />
                </div>

                <div class="mt-6 flex justify-end">
                    <SecondaryButton @click="isUpdate ? updateData() : storeData()"> Save </SecondaryButton>
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
                                <Link :href="route('adminDashboard')">
                                    <ApplicationLogo
                                        class="block h-9 w-auto fill-current text-gray-800 dark:text-gray-200"
                                    />
                                </Link>
                            </div>

                            <!-- Navigation Links -->
                            <div class="hidden space-x-8 sm:-my-px sm:ms-10 sm:flex">
                                <NavLink :href="route('adminDashboard')" :active="route().current('adminDashboard')">
                                    Dashboard
                                </NavLink>
                                <NavLink :href="route('adminProduct')" :active="route().current('adminProduct')">
                                    Products
                                </NavLink>
                                <NavLink :href="route('report')" :active="route().current('report')">
                                    Report
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
                <div class="py-12">
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
                                                <span class="text-xs font-medium uppercase leading-4 tracking-wider text-gray-500">Nama Report</span>
                                            </th>
                                            <th class="bg-gray-50 px-6 py-3 text-left">
                                                <span class="text-xs font-medium uppercase leading-4 tracking-wider text-gray-500">View Path</span>
                                            </th>
                                            <th class="w-56 bg-gray-50 px-6 py-3 text-left">
                                            </th>
                                        </tr>
                                        </thead>
            
                                        <tbody class="bg-white divide-y divide-gray-200 divide-solid">
                                            <tr class="bg-white" v-for="(item, index) in packages.data" :key="index">
                                                <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                                                    {{ item.report_name }}
                                                </td>
                                                <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                                                    {{ item.report_view }}
                                                </td>
                                                <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                                                    <PrimaryButton @click="exportPDF(item)">Export PDF</PrimaryButton>
                                                    <br>
                                                    <br>
                                                    <PrimaryButton @click="viewPDF(item)">View PDF</PrimaryButton>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br>
                                    <TailwindPagination
                                        :data="packages"
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
    name: 'PaketList',
    data() {
        return {
            'url': 'http://localhost:8000/api/report',
            'packages': {
                'id': '',
                'report_name': '',
                'report_view': ''
            },
            'isUpdate': false
        }
    },
    created() {
        this.getData();
    },
    methods: {
        openModal() {
            openingModal.value = true;
            this.packages.report_name = '';
            this.packages.report_view = 0;
            this.packages.password = '';
            this.packages.password_confirmation = '';
            this.isUpdate = false;
        },

        openModalEdit(item) {
            openingModal.value = true;
            this.packages.id = item.id;
            this.packages.report_name = item.report_name;
            this.packages.report_view = item.report_view;
            this.isUpdate = true;
        },

        openModalDelete(item) {
            confirmingUserDeletion.value = true;
            this.packages.id = item.id;
            this.isUpdate = true;
        },

        closeModal() {
            openingModal.value = false;
            this.packages.report_name = '';
            this.packages.report_view = 0;
        },

        closeModalDelete() {
            confirmingUserDeletion.value = false;
            this.packages.report_name = '';
            this.packages.report_view = 0;
        },

        async getData() {
            await axios.get(this.url).then(response => {
                this.packages = response.data.data;
            }).catch(error => {
                console.log(error);
            });
        },

        async storeData() {
            let formData = new FormData();
            formData.append('report_name', this.packages.report_name);
            formData.append('report_view', this.packages.report_view);

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

        async updateData() {
            let formData = new FormData();
            formData.append('report_name', this.packages.report_name);
            formData.append('report_view', this.packages.report_view);
            formData.append("_method", "put");

            await axios.post(this.url + '/' + this.packages.id, formData).then(response => {
                this.$toast.success('Data Updated Successfully', {
                    position: 'top-right'
                });
                openingModal.value = false;
                this.getData();
            }).catch(error => {
                console.log(error);
            });
        },

        async deleteData() {
            await axios.delete(this.url + '/' + this.packages.id).then(response => {
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
                this.packages = response.data.data;
            }).catch(error => {
                console.log(error);
            });
        },

        async exportPDF() {
            await axios.get(this.url + '/download-pdf', {responseType: 'blob'}).then(response => {
                const url = URL.createObjectURL(response.data);
                const a = document.createElement('a');
                a.style = 'display: none';
                a.href = url;
                a.download = 'file.pdf';
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
                URL.revokeObjectURL(url);
                confirmingUserDeletion.value = false;
                this.getData();
            }).catch(error => {
                console.log(error);
            });
        },

        async viewPDF() {
            await axios.get(this.url + '/stream-pdf', {responseType: 'blob'}).then(response => {
                const url = URL.createObjectURL(response.data);
                window.open(url);
                confirmingUserDeletion.value = false;
                this.getData();
            }).catch(error => {
                console.log(error);
            });
        }
    }
}
</script>