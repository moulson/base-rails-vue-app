<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-50">
    <div class="max-w-md w-full space-y-8">
      <div>
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">Update your profile</h2>
      </div>
      <form class="mt-8 space-y-6" @submit.prevent="updateUser">
        <div class="rounded-md shadow-sm -space-y-px">
          <div>
            <input
              v-model="form.email_address"
              type="email"
              required
              class="relative block w-full px-3 py-2 border border-gray-300 rounded-md placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              placeholder="Email address"
            />
          </div>
        </div>
        <div class="rounded-md shadow-sm -space-y-px">
          <div>
            <input
              v-model="form.display_name"
              required
              class="relative block w-full px-3 py-2 border border-gray-300 rounded-md placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              placeholder="Display Name"
            />
          </div>
        </div>
        <div>
          <button
            type="submit"
            :disabled="loading"
            class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 disabled:opacity-50"
          >
            {{ loading ? 'Saving...' : 'Save Changes' }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import apiClient from '@/services/api'
import { toast } from 'vue-sonner'

const router = useRouter()
const authStore = useAuthStore()

const form = reactive({
  email_address: '',
  display_name: '',
})
let loading = false

const updateUser = async () => {
  try {
    loading = true
    const response = await apiClient.put('/user', {
      user: form,
    })
    if (response.status === 200) {
      console.log('updated')
      toast.success('Profile saved!')
    }
  } catch (error) {
    console.error('Error updating profile', error)
    toast.error('Error updating profile')
  } finally {
    loading = false
  }
}

onMounted(async () => {
  try {
    await authStore.fetchCurrentUser()
    ;(form.email_address = authStore.user?.email_address || ''),
      (form.display_name = authStore.user?.display_name || '')
  } catch (error) {
    console.error('Failed to fetch user:', error)
  }
})
</script>
