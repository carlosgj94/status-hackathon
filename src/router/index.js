import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Create from '@/components/Create'

Vue.use(Router)

export default new Router({
  routes: [
    {
      mode: 'history',
      path: '/',
      name: 'Root',
      component: Home
    },
    {
      mode: 'history',
      path: '/home',
      name: 'Home',
      component: Home
    },
    {
      mode: 'history',
      path: '/create',
      name: 'Create Bond',
      component: Create
    }
  ]
})