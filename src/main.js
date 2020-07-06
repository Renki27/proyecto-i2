import Vue from 'vue';
import App from './App.vue'
//Componentes
import Home from "./components/Home.vue";
import SignUp from "./components/SignUp.vue";
import SignIn from "./components/SignIn.vue";
import Profile from "./components/Profile.vue";
import PageNotFound from "./components/PageNotFound.vue";
// Router
import VueRouter from 'vue-router';
//Axios
import Axios from 'axios';
//Store de vuex
import store from './js/store';
//Notifactions
import Notifications from 'vue-notification'
//Vue select
import vSelect from 'vue-select'
Vue.component('v-select', vSelect)

//interceptors axios
import interceptorsSetup from './js/Interceptors'

interceptorsSetup();




Vue.use(VueRouter);
Vue.use(Notifications)


// set auth header
Axios.defaults.headers.common['Authorization'] = `Bearer ${store.state.token}`;



const router = new VueRouter({
    mode: 'history', //modo clasico de rutas
    base: __dirname, //abarca el proyecto
    routes: [
        {
            path: '/',
            name: "home",
            component: Home
        },
        {
            path: '/SignUp',
            name: "sign-up",
            component: SignUp
        },
        {
            path: '/SignIn',
            name: "sign-in",
            component: SignIn

        },
        {
            path: '/Profile',
            name: "profile",
            component: Profile
        },
        { path: "*", 
        component: PageNotFound }
    ]

})
/*
new Vue ({
    render: h => h(App) 
    //para montar la app en el id App
}).$mount('#app');*/

/*
new Vue({
    el: '#app',
    template: '<App/>',
    components: { App }
})*/

new Vue({
    router,
    store,
    template: '<App/>',
    components: { App }
}).$mount('#app');