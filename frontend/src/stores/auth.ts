import { defineStore } from 'pinia'
import apiClient from '@/services/api'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: JSON.parse(localStorage.getItem('user')),
    token: localStorage.getItem('token') || null,
    isLoading: false,
    error: null,
  }),

  getters: {
    isAuthenticated: (state) => !!state.token,
    currentUser: (state) => state.user,
  },

  actions: {
    async login(email: String, password: String) {
      this.isLoading = true
      this.error = null

      try {
        const response = await apiClient.post('/session', {
          user: { email_address: email, password: password },
        })

        const { token, user } = response.data

        this.token = token
        this.user = user

        localStorage.setItem('token', token)
        localStorage.setItem('user', JSON.stringify(user))

        return { success: true }
      } catch (error: any) {
        this.error = error.response?.data?.error || 'Login failed'
        return { success: false, error: this.error }
      } finally {
        this.isLoading = false
      }
    },

    async register(email: string, password: string, passwordConfirmation: string) {
      this.isLoading = true
      this.error = null

      try {
        const response = await apiClient.post('/user', {
          user: {
            email_address: email,
            password,
            password_confirmation: passwordConfirmation,
          },
        })
        const { token, user } = response.data
        this.token = token
        this.user = user

        localStorage.setItem('token', token)
        localStorage.setItem('user', JSON.stringify(user))
        return { success: true }
      } catch (error: any) {
        this.error = error.response?.data?.errors || 'Registration failed'
        return { success: false, error: this.error }
      } finally {
        this.isLoading = false
      }
    },

    async logout() {
      try {
        await apiClient.delete('/session')
      } catch (error) {
        console.error('Logout error:', error)
      } finally {
        this.token = null
        this.user = null
        localStorage.removeItem('token')
        localStorage.removeItem('user')
      }
    },

    async fetchCurrentUser() {
      if (!this.token) return

      try {
        const response = await apiClient.get('/session')
        this.user = response.data.user
        localStorage.setItem('user', JSON.stringify(this.user))
      } catch (error) {
        console.error('Failed to fetch current user:', error)
        this.logout()
      }
    },
  },
})
