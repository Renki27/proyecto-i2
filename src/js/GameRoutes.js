import axios from 'axios';
const url = "http://localhost/proyecto-i2/api/";

export default {
    addGame(gameData) {
        return axios
            .post(url + '/addGame.php', gameData, {
                headers: { 'Content-Type': 'multipart/form-data' }
            })
            .then(response => response.data);

    },

    updateGame(gameData) {
        return axios
            .post(url + '/updateGame.php', gameData, {
                headers: { 'Content-Type': 'multipart/form-data' }
            })
            .then(response => response.data);

    },

    deleteGame(id_game) {
        return axios
            .post(url + '/deleteGame.php', id_game, {
                headers: { 'Content-Type': 'multipart/form-data' }
            })
            .then(response => response.data);
    },

    loadGames() {
        return axios
            .get(url + "/loadGames.php?request=loadGames")
            .then(response => response.data);
    },

}