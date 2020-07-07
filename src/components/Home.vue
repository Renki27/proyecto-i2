<template>
  <div>
    <Carousel />
    <div class="mx-auto mt-50">
      <div class="row">
        <div class="col align-self-center">
          <h1 class="main-title display-1 text-center animate__animated animate__fadeInDown">
            <strong>GAMES LAB</strong>
          </h1>
          <h2
            class="sec-title display-4 text-center animate__animated animate__fadeInDown animate__slow"
          >Videogames Portal</h2>
        </div>
      </div>
      <div
        class="container mx-auto mt-50 bg-white animate__animated animate__fadeInUp animate__slow"
      >
        <p class="lead text-center">
          Find within the games catalog the latest releases and
          the most popular video games, with a complete description
          and the platforms on which it is available.
        </p>
      </div>
      <div class="carousel-wrapper mb-4" v-show="gamesLibrary.length">
        <div class="carousel" data-flickity>
          <div class="carousel-cell" v-for="game in gamesLibrary" v-bind:key="gamesLibrary.id_game">
            <h3 class="color-white mb-2">{{game.title}}</h3>
            <img class="thumb-img" :src="game.image" />
            <div class="col-12 align-items-center mt-2">
              <p
                class="text-center small text-truncate font-weight-light color-white"
              >{{game.description}}</p>
            </div>
            <a class="more text-center" v-on:click="loadGame(game.id_game)" v-show="hide">show more</a>
            <div class="arrow down" v-show="hide"></div>
            <a class="more text-center" v-on:click="hide= true" v-show="!hide">hide</a>
            <div class="arrow up" v-show="!hide"></div>
          </div>
        </div>
      </div>
      <div v-if="!this.hide" class="row align-items-center">
        <h2
          class="sec-title display-4 text-center col-12 animate__animated animate__fadeInDown"
        >{{this.currentGame.title}} - video</h2>
        <div
          class="video-container bg-black-radial col-xl-12 mt-20 animate__animated animate__fadeInUp animate__slow"
        >
          <div class="container embed-responsive embed-responsive-16by9 red-box">
            <iframe
              class="embed-responsive-item"
              :src="this.currentGame.video_link"
              allowfullscreen
            ></iframe>
          </div>
        </div>
        <div class="cover-large col-12 animate__animated animate__fadeInUp animate__slower">
          <img :src="this.currentGame.image" class="img-fluid" alt="COVER" />
        </div>
        <div class="col-12 align-self-center bg-black-gradient">
          <div
            class="bg-white container title-card mx-auto align-items-center cover-large col-12 animate__animated animate__fadeInUp animate__slow animate__delay-2s"
          >
            <div class="col-sm-12">
              <h3
                class="main-title display-3 text-center font-weight-bold color-red mt-100"
              >{{this.currentGame.title}}</h3>
            </div>
            <hr />
            <div class="col-sm-12 mx-auto mt-5">
              <p>
                <strong class="color-blue">Description:</strong>
              </p>
              <div class="col-sm-12 lead text-center mx-auto">
                <textarea
                  v-model="this.currentGame.description"
                  class="form-control ta-description lead text-center"
                  maxlength="1000"
                  spellcheck="false"
                ></textarea>
              </div>
            </div>

            <div class="mt-5">
              <p>
                <strong class="color-blue">Genre:</strong>
                {{this.currentGame.genre}}
              </p>
              <p>
                <strong class="color-blue">Publisher:</strong>
                {{this.currentGame.publisher}}
              </p>
              <p>
                <strong class="color-blue">Developer:</strong>
                {{this.currentGame.developer}}
              </p>
              <p>
                <strong class="color-blue">Supported platforms:</strong>
                {{this.currentGame.platform}}
              </p>
              <p>
                <strong class="color-blue">Release year:</strong>
                {{this.currentGame.released_on}}
              </p>
              <p>
                <strong class="color-blue">Multiplayer:</strong>
                {{this.currentGame.multiplayer}}
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <Footer />
  </div>
</template>

<script>
import Carousel from "./Carousel.vue";
import Footer from "./Footer.vue";
import gameOps from "../js/GameRoutes";
export default {
  name: "home",
  data() {
    return {
      hide: true,
      currentGame: "",
      gamesLibrary: []
    };
  },
  components: {
    Carousel,
    Footer
  },
  methods: {
    loadGame(id) {
      this.hide = false;

      this.gamesLibrary.forEach(game => {
        if (game.id_game == id) {
          this.currentGame = game;
        }
      });
    },
    autoHide() {},
    async loadLibrary() {
      try {
        (async () => {
          const response = await gameOps.loadGames();

          if (response.status == 200) {
            response.gamesLibrary.forEach(game => {
              this.gamesLibrary.push(game);
            });
          }
        })();
      } catch (error) {}
    }
  },
  mounted() {
    let cardCarouselScript = document.createElement("script");
    cardCarouselScript.setAttribute(
      "src",
      "https://unpkg.com/flickity@2.0/dist/flickity.pkgd.min.js"
    );
    document.head.appendChild(cardCarouselScript);
  },
  async created() {
    this.loadLibrary();
  }
};
</script>