import Axios from 'axios';
import store from './store'

export default function setup() {
    Axios.interceptors.request.use(function (config) {
        const token = store.getters.isLoggedIn;
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
            
        }
        return config;
    }, function (err) {
        return Promise.reject(err);
    });
}