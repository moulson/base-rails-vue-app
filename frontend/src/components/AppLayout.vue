<template>
  <div class="min-h-screen bg-gray-50">
    <!-- Sidebar Overlay -->
    <TransitionRoot as="template" :show="sidebarOpen">
      <Dialog as="div" class="relative z-50 lg:hidden" @close="sidebarOpen = false">
        <TransitionChild
          as="template"
          enter="transition-opacity ease-linear duration-300"
          enter-from="opacity-0"
          enter-to="opacity-100"
          leave="transition-opacity ease-linear duration-300"
          leave-from="opacity-100"
          leave-to="opacity-0"
        >
          <br class="fixed inset-0 bg-gray-900/80" />
        </TransitionChild>

        <div class="fixed inset-0 flex">
          <TransitionChild
            as="template"
            enter="transition ease-in-out duration-300 transform"
            enter-from="-translate-x-full"
            enter-to="translate-x-0"
            leave="transition ease-in-out duration-300 transform"
            leave-from="translate-x-0"
            leave-to="-translate-x-full"
          >
            <DialogPanel class="relative mr-16 flex w-full max-w-xs flex-1">
              <TransitionChild
                as="template"
                enter="ease-in-out duration-300"
                enter-from="opacity-0"
                enter-to="opacity-100"
                leave="ease-in-out duration-300"
                leave-from="opacity-100"
                leave-to="opacity-0"
              >
                <div class="absolute left-full top-0 flex w-16 justify-center pt-5">
                  <button type="button" class="-m-2.5 p-2.5" @click="sidebarOpen = false">
                    <span class="sr-only">Close sidebar</span>
                    <XMarkIcon class="h-6 w-6 text-white" aria-hidden="true" />
                  </button>
                </div>
              </TransitionChild>

              <!-- Sidebar content -->
              <div
                class="flex grow flex-col gap-y-5 overflow-y-auto bg-white px-6 pb-2 ring-1 ring-white/10"
              >
                <div class="flex h-16 shrink-0 items-center">
                  <h2 class="text-xl font-semibold text-gray-900">Menu</h2>
                </div>
                <nav class="flex flex-1 flex-col">
                  <ul role="list" class="flex flex-1 flex-col gap-y-7">
                    <li>
                      <ul role="list" class="-mx-2 space-y-1">
                        <li v-for="item in navigation" :key="item.name">
                          <router-link
                            @click="sidebarOpen = false"
                            :to="item.href"
                            :class="[
                              item.current
                                ? 'bg-indigo-50 text-indigo-600'
                                : 'text-gray-700 hover:text-indigo-600 hover:bg-gray-50',
                              'group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold',
                            ]"
                          >
                            <component
                              :is="item.icon"
                              :class="[
                                item.current
                                  ? 'text-indigo-600'
                                  : 'text-gray-400 group-hover:text-indigo-600',
                                'h-6 w-6 shrink-0',
                              ]"
                              aria-hidden="true"
                            />
                            {{ item.name }}
                          </router-link>
                        </li>
                      </ul>
                    </li>
                    <li>
                      <div class="text-xs font-semibold leading-6 text-gray-400">Account</div>
                      <ul role="list" class="-mx-2 mt-2 space-y-1">
                        <li v-for="item in accountItems" :key="item.name">
                          <router-link
                            @click="sidebarOpen = false"
                            :to="item.href"
                            class="text-gray-700 hover:text-indigo-600 hover:bg-gray-50 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold"
                          >
                            <component
                              :is="item.icon"
                              class="text-gray-400 group-hover:text-indigo-600 h-6 w-6 shrink-0"
                              aria-hidden="true"
                            />
                            {{ item.name }}
                          </router-link>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </nav>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </Dialog>
    </TransitionRoot>

    <!-- Main content area -->
    <div class="pb-20">
      <div class="px-4 py-8">
        <div class="mx-auto max-w-7xl">
          <RouterView></RouterView>
        </div>
      </div>
    </div>

    <!-- Bottom Navigation Bar -->
    <div class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 z-40">
      <div class="grid grid-cols-2 h-16">
        <!-- Home -->
        <button
          @click="navigateTo('home')"
          :class="[
            'flex flex-col items-center justify-center space-y-1 transition-colors duration-200',
            currentPage === 'home' ? 'text-indigo-600' : 'text-gray-400 hover:text-gray-600',
          ]"
        >
          <HomeIcon class="h-6 w-6" />
          <span class="text-xs font-medium">Home</span>
        </button>

        <!-- Menu -->
        <button
          @click="openMenu"
          class="flex flex-col items-center justify-center space-y-1 text-gray-400 hover:text-gray-600 transition-colors duration-200"
        >
          <Bars3Icon class="h-6 w-6" />
          <span class="text-xs font-medium">Menu</span>
        </button>
      </div>
    </div>
    <Toaster></Toaster>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { RouterLink, RouterView, useRouter } from 'vue-router'
import { Dialog, DialogPanel, TransitionChild, TransitionRoot } from '@headlessui/vue'
import { Toaster } from '@/components/ui/sonner'
import 'vue-sonner/style.css'
import {
  Bars3Icon,
  HomeIcon,
  XMarkIcon,
  UserIcon,
  DocumentTextIcon,
  ChartBarIcon,
  CogIcon,
  QuestionMarkCircleIcon,
  ArrowRightOnRectangleIcon,
} from '@heroicons/vue/24/outline'

const sidebarOpen = ref(false)
const currentPage = ref('home')

const navigation = [
  { name: 'Dashboard', href: '/dashboard', icon: ChartBarIcon, current: false },
  { name: 'Documents', href: '/documents', icon: DocumentTextIcon, current: false },
  { name: 'Reports', href: '/reports', icon: ChartBarIcon, current: false },
]

const accountItems = [
  { name: 'Profile', href: '/profile', icon: UserIcon },
  { name: 'Settings', href: '/settings', icon: CogIcon },
  { name: 'Help', href: '/help', icon: QuestionMarkCircleIcon },
  { name: 'Sign out', href: '/logout', icon: ArrowRightOnRectangleIcon },
]

const currentPageTitle = computed(() => {
  return currentPage.value === 'home' ? 'Home' : 'Dashboard'
})

const navigateTo = (page) => {
  currentPage.value = page
}

const openMenu = () => {
  sidebarOpen.value = true
}
</script>
