// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import VueMaterial from 'vue-material'
//import VueRouter from 'vue-router'
import VueResource from 'vue-resource'

//import router from './router'
import 'vue-material/dist/vue-material.css'

Vue.use(VueMaterial)
//Vue.use(VueRouter)
Vue.use(VueResource)

var data = {
  life_history: [],
}

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<App/>',
  components: { App },
  data
})
