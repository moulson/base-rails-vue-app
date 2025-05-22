<template>
  <div class="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
    <!-- Navigation -->
    <nav class="bg-white shadow-lg">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
          <div class="flex items-center">
            <h1 class="text-2xl font-bold text-gray-900">Rails + Vue App</h1>
          </div>
          <div class="flex items-center space-x-4">
            <template v-if="authStore.isAuthenticated">
              <span class="text-gray-700">Welcome, {{ authStore.currentUser?.email }}</span>
              <router-link
                to="/dashboard"
                class="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium transition-colors"
              >
                Dashboard
              </router-link>
              <button
                @click="handleLogout"
                class="bg-gray-600 hover:bg-gray-700 text-white px-4 py-2 rounded-md text-sm font-medium transition-colors"
              >
                Logout
              </button>
            </template>
            <template v-else>
              <router-link
                to="/login"
                class="text-gray-700 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium transition-colors"
              >
                Login
              </router-link>
              <router-link
                to="/register"
                class="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium transition-colors"
              >
                Sign Up
              </router-link>
            </template>
          </div>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <div class="text-center">
        <h1 class="text-4xl md:text-6xl font-bold text-gray-900 mb-6">
          Welcome to Your
          <span class="text-indigo-600">Rails + Vue</span>
          Application
        </h1>
        <p class="text-xl text-gray-600 mb-8 max-w-3xl mx-auto">
          A modern full-stack application built with Rails 8 API backend and Vue.js 3 frontend.
          Experience seamless authentication, RESTful APIs, and a responsive user interface.
        </p>

        <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
          <template v-if="!authStore.isAuthenticated">
            <router-link
              to="/register"
              class="bg-indigo-600 hover:bg-indigo-700 text-white px-8 py-3 rounded-lg text-lg font-semibold transition-all transform hover:scale-105 shadow-lg"
            >
              Get Started
            </router-link>
            <router-link
              to="/login"
              class="bg-white hover:bg-gray-50 text-indigo-600 px-8 py-3 rounded-lg text-lg font-semibold border-2 border-indigo-600 transition-all transform hover:scale-105 shadow-lg"
            >
              Sign In
            </router-link>
          </template>
          <template v-else>
            <router-link
              to="/dashboard"
              class="bg-indigo-600 hover:bg-indigo-700 text-white px-8 py-3 rounded-lg text-lg font-semibold transition-all transform hover:scale-105 shadow-lg"
            >
              Go to Dashboard
            </router-link>
          </template>
        </div>
      </div>

      <!-- Features Section -->
      <div class="mt-20 grid grid-cols-1 md:grid-cols-3 gap-8">
        <div class="bg-white rounded-lg shadow-lg p-6 text-center">
          <div
            class="w-12 h-12 bg-indigo-100 rounded-lg flex items-center justify-center mx-auto mb-4"
          >
            <svg
              class="w-6 h-6 text-indigo-600"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M13 10V3L4 14h7v7l9-11h-7z"
              ></path>
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 mb-2">Fast & Modern</h3>
          <p class="text-gray-600">
            Built with the latest versions of Rails 8 and Vue.js 3 for optimal performance and
            developer experience.
          </p>
        </div>

        <div class="bg-white rounded-lg shadow-lg p-6 text-center">
          <div
            class="w-12 h-12 bg-indigo-100 rounded-lg flex items-center justify-center mx-auto mb-4"
          >
            <svg
              class="w-6 h-6 text-indigo-600"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
              ></path>
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 mb-2">Secure Authentication</h3>
          <p class="text-gray-600">
            JWT-based authentication with secure token handling and automatic session management.
          </p>
        </div>

        <div class="bg-white rounded-lg shadow-lg p-6 text-center">
          <div
            class="w-12 h-12 bg-indigo-100 rounded-lg flex items-center justify-center mx-auto mb-4"
          >
            <svg
              class="w-6 h-6 text-indigo-600"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"
              ></path>
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
              ></path>
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 mb-2">RESTful API</h3>
          <p class="text-gray-600">
            Clean, conventional REST endpoints that follow Rails best practices for easy
            integration.
          </p>
        </div>
      </div>

      <!-- Tech Stack -->
      <div class="mt-20 text-center">
        <h2 class="text-3xl font-bold text-gray-900 mb-8">Built With</h2>
        <div class="flex flex-wrap justify-center items-center gap-8">
          <div class="flex items-center space-x-2 bg-white rounded-lg px-4 py-2 shadow-md">
            <span class="text-red-600 font-bold">♦</span>
            <span class="font-semibold text-gray-700">Ruby on Rails 8</span>
          </div>
          <div class="flex items-center space-x-2 bg-white rounded-lg px-4 py-2 shadow-md">
            <span class="text-green-600 font-bold">▲</span>
            <span class="font-semibold text-gray-700">Vue.js 3</span>
          </div>
          <div class="flex items-center space-x-2 bg-white rounded-lg px-4 py-2 shadow-md">
            <span class="text-blue-600 font-bold">⚡</span>
            <span class="font-semibold text-gray-700">Vite</span>
          </div>
          <div class="flex items-center space-x-2 bg-white rounded-lg px-4 py-2 shadow-md">
            <span class="text-purple-600 font-bold">🍍</span>
            <span class="font-semibold text-gray-700">Pinia</span>
          </div>
          <div class="flex items-center space-x-2 bg-white rounded-lg px-4 py-2 shadow-md">
            <span class="text-cyan-600 font-bold">💨</span>
            <span class="font-semibold text-gray-700">Tailwind CSS</span>
          </div>
        </div>
      </div>
    </main>

    <!-- Footer -->
    <footer class="bg-white border-t border-gray-200 mt-20">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="text-center text-gray-600">
          <p>&copy; 2025 Rails + Vue App. Built with ❤️ for modern web development.</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const handleLogout = async () => {
  await authStore.logout()
  router.push('/')
}
</script>
