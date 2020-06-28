import axios from 'axios';
const url = "http://localhost/proyecto-i2/api/";

export default {
    createAccount(userData) {
        return axios
            .post(url + '/signup.php', userData)
            .then(response => response.data);

    },

    login(userData) {

        return axios
            .post(url + "/signin.php?request=getUser", userData)
            .then(response => response.data);
    },


    verifyUser(username) {
        return axios
            .get(url + "/signin.php?request=verify&username=" + username)
            //El response con arrow function si guarda los datos, sino no los asigna a la variable
            .then(response => response.data.verifyUser);
    }
}