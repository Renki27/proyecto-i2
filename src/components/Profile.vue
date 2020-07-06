<template>
  <div v-if="this.$store.getters.logged">
    <div class="col-2">
      <img class="float-left rounded-circle avatar" />
      <h2 class="sec-title display-4 text-center text-uppercase">{{ username }}</h2>
    </div>

    <hr />
    <div class="row">
      <div class="col-sm-2">
        <div class="list-group mt-2" id="list-tab" role="tablist">
          <a
            class="list-group-item list-group-item-action active"
            id="list-add-game-list"
            data-toggle="list"
            href="#list-add-game"
            role="tab"
            aria-controls="add-game"
            v-on:click="clearFields"
          >Add Game</a>
          <a
            class="list-group-item list-group-item-action"
            id="list-update-game-list"
            data-toggle="list"
            href="#list-update-game"
            role="tab"
            aria-controls="update-game"
            v-on:click="clearFields, hideUpdate = true, updateSelection = '' "
          >Update Game</a>
          <a
            class="list-group-item list-group-item-action"
            id="list-delete-game-list"
            data-toggle="list"
            href="#list-delete-game"
            role="tab"
            aria-controls="delete-game"
            v-on:click="deleteSelection = '' "
          >Delete Game</a>
          <a
            class="list-group-item list-group-item-action bg-blue color-white"
            id="list-logout-list"
            data-toggle="list"
            href="#list-logout"
            role="tab"
            aria-controls="logout"
            v-on:click="logout"
          >Log Out</a>
        </div>
      </div>
      <div class="col-8">
        <div class="tab-content" id="nav-tabContent">
          <div
            class="tab-pane fade show active"
            id="list-add-game"
            role="tabpanel"
            aria-labelledby="list-add-game-list"
          >
            <div>
              <div class="card-body">
                <h5
                  class="card-title text-center animate__animated animate__fadeInDown"
                >Add a new Game</h5>
                <hr class="my-4" />
                <form class="form-signin" v-on:submit="addGame">
                  <div class="row animate__animated animate__bounceInRight animate__animate__slow">
                    <div class="col-md-12">
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Title:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.title"
                                placeholder="Title of the game"
                                required
                              />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Genre:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.genre"
                                placeholder="Game genre"
                              />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Publisher:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.publisher"
                                placeholder="Publisher company"
                              />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Developer:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.developer"
                                placeholder="Developer company"
                              />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Platforms:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.platform"
                                placeholder="Supported platforms"
                              />
                            </div>
                          </div>
                        </div>

                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Released on:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.released_on"
                                placeholder="Release year"
                                maxlength="4"
                                minlength="4"
                                v-on:keypress="validateNumbers"
                                v-on:paste.prevent
                              />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Multiplayer:</label>
                            <div class="col-md-9">
                              <select
                                name="multiplayer"
                                class="custom-select custom-select mb-3"
                                v-model="game.multiplayer"
                                required
                              >
                                <option selected default value disabled>Choose...</option>
                                <option value="1">Yes</option>
                                <option value="2">No</option>
                              </select>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Trailer video:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="videoField"
                                placeholder="Link of the video trailer"
                                required
                              />
                            </div>
                          </div>
                        </div>
                        <div class="container">
                          <div class="row">
                            <div class="col-sm-4 mt-4 text-center">
                              <figure class="figure text-center">
                                <img
                                  :src="imageData"
                                  class="figure-img img-fluid rounded thumb-small text-center"
                                  alt="Game Image."
                                />
                                <figcaption class="figure-caption">
                                  <div class="custom-file">
                                    <small>
                                      <small>
                                        <input
                                          type="file"
                                          name="image"
                                          class="form-control-file"
                                          id="image"
                                          accept="image/*"
                                          v-on:change="previewImage"
                                          required
                                        />
                                        <label class="custom-file-label" for="image">Choose file</label>
                                      </small>
                                    </small>
                                  </div>
                                </figcaption>
                              </figure>
                            </div>

                            <div class="col-sm-8">
                              <label for class="col-md-3 col-form-label">Description:</label>
                              <div class="form-group row">
                                <div class="col-md-12">
                                  <textarea
                                    name="description"
                                    id="gameDescription"
                                    cols="10"
                                    rows="7"
                                    class="form-control"
                                    v-model="game.description"
                                    maxlength="1000"
                                    wrap="soft"
                                    placeholder="Synopsis / Requirements"
                                  ></textarea>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="container-fluid">
                    <div class="row justify-content-end">
                      <div class="col-sm-3">
                        <button
                          class="btn btn-lg btn-primary btn-block text-uppercase mt-50"
                          type="button"
                          v-on:click="clearFields"
                        >Clear</button>
                      </div>
                      <div class="col-sm-3">
                        <button
                          class="btn btn-lg btn-primary btn-block text-uppercase mt-50"
                          type="submit"
                        >Add game</button>
                      </div>
                    </div>
                  </div>
                  <hr />
                </form>
              </div>
            </div>
          </div>
          <!-- Update game -->
          <div
            class="tab-pane fade"
            id="list-update-game"
            role="tabpanel"
            aria-labelledby="list-update-game-list"
          >
            <div>
              <div class="card-body">
                <h5
                  class="card-title text-center animate__animated animate__fadeInDown"
                >Update a Game</h5>
                <hr class="my-4" />
                <div
                  class="col-sm-6 over form-signin mt-4 mx-auto animate__animated animate__bounceInRight animate__animate__slow"
                >
                  <v-select
                    name="update-game"
                    class="mb-5 over animate__animated animate__fadeIn animate__slow"
                    :options="gamesLibrary"
                    v-model="updateSelection"
                    :value="gamesLibrary.id_game"
                    :reduce="gamesLibrary => gamesLibrary.id_game"
                    label="title"
                    :required="!updateSelection"
                  ></v-select>
                  <div
                    class="col-sm-6 mx-auto animate__animated animate__fadeIn animate__animate__slow"
                  >
                    <button
                      class="btn btn-lg btn-danger btn-block text-uppercase"
                      type="submit"
                      v-on:click="selectGame()"
                    >Select game</button>
                  </div>
                </div>
                <hr class="my-4" />
                <!-- Update form -->
                <form class="form-signin under" v-if="!hideUpdate" v-on:submit="updateGame">
                  <div class="row animate__animated animate__bounceInRight animate__animate__slow">
                    <div class="col-md-12">
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Title:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.title"
                                placeholder="Title of the game"
                                required
                              />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Genre:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.genre"
                                placeholder="Game genre"
                              />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Publisher:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.publisher"
                                placeholder="Publisher company"
                              />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Developer:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.developer"
                                placeholder="Developer company"
                              />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Platforms:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.platform"
                                placeholder="Supported platforms"
                              />
                            </div>
                          </div>
                        </div>

                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Released on:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="game.released_on"
                                placeholder="Release year"
                                maxlength="4"
                                minlength="4"
                                v-on:keypress="validateNumbers"
                                v-on:paste.prevent
                              />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Multiplayer:</label>
                            <div class="col-md-9">
                              <select
                                name="multiplayer"
                                class="custom-select custom-select mb-3"
                                v-model="game.multiplayer"
                                required
                              >
                                <option selected default value disabled>Choose...</option>
                                <option value="1">Yes</option>
                                <option value="2">No</option>
                              </select>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for class="col-md-3 col-form-label">Trailer video:</label>
                            <div class="col-md-9">
                              <input
                                type="text"
                                class="form-control"
                                v-model="videoField"
                                placeholder="Link of the video trailer"
                                required
                              />
                            </div>
                          </div>
                        </div>
                        <div class="container">
                          <div class="row justify-content-end">
                            <div class="col-sm-4 mt-4 text-center">
                              <figure class="figure text-center">
                                <img
                                  :src="imageData"
                                  class="figure-img img-fluid rounded thumb-small text-center"
                                  alt="Game Image."
                                />
                                <figcaption class="figure-caption">
                                  <div class="custom-file">
                                    <small>
                                      <small>
                                        <input
                                          type="file"
                                          class="custom-file-input"
                                          id="imgUploadU"
                                          accept="image/*"
                                          v-on:change="previewImage"
                                        />
                                        <label
                                          class="custom-file-label"
                                          for="imgUploadU"
                                        >Choose file</label>
                                      </small>
                                    </small>
                                  </div>
                                </figcaption>
                              </figure>
                            </div>

                            <div class="col-sm-8">
                              <label for class="col-md-3 col-form-label">Description:</label>
                              <div class="form-group row">
                                <div class="col-md-12">
                                  <textarea
                                    name="description"
                                    id="gameDescriptionU"
                                    cols="10"
                                    rows="7"
                                    class="form-control"
                                    v-model="game.description"
                                    maxlength="500"
                                    wrap="soft"
                                    placeholder="Synopsis / Requirements"
                                  ></textarea>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="container-fluid">
                    <div class="row justify-content-end">
                      <div class="col-sm-3">
                        <button
                          class="btn btn-lg btn-primary btn-block text-uppercase mt-2"
                          type="button"
                          v-on:click="clearFields"
                        >Clear</button>
                      </div>
                      <div class="col-sm-3">
                        <button
                          class="btn btn-lg btn-primary btn-block text-uppercase mt-2"
                          type="submit"
                        >Update game</button>
                      </div>
                    </div>
                  </div>
                  <hr />
                </form>
              </div>
            </div>
          </div>
          <!-- Delete game -->
          <div
            class="tab-pane fade"
            id="list-delete-game"
            role="tabpanel"
            aria-labelledby="list-delete-game-list"
          >
            <div>
              <div class="card-body">
                <h5
                  class="card-title text-center animate__animated animate__fadeInDown"
                >Delete a Game</h5>
                <hr class="my-4" />
                <!-- Select delete game form -->
                <div class="row align-items-center">
                  <form class="form-signin" v-on:submit="deleteGame">
                    <div class="form-label-group">
                      <div
                        class="col-sm-6 over mt-4 mx-auto animate__animated animate__bounceInRight animate__animate__slow"
                      >
                        <v-select
                          name="delete-game"
                          class="mb-5 over animate__animated animate__fadeIn animate__slow"
                          :options="gamesLibrary"
                          v-model="deleteSelection"
                          :value="gamesLibrary.id_game"
                          :reduce="gamesLibrary => gamesLibrary.id_game"
                          label="title"
                          :required="!deleteSelection"
                        ></v-select>
                        <div
                          class="col-sm-6 mx-auto animate__animated animate__fadeIn animate__animate__slow"
                        >
                          <button
                            class="btn btn-lg btn-danger btn-block text-uppercase"
                            type="button"
                            data-toggle="modal"
                            data-target="#deleteModal"
                            v-on:click="notifySelection"
                          >Delete game</button>
                        </div>
                      </div>
                    </div>
                    <!-- Modal -->
                    <div
                      class="modal fade"
                      id="deleteModal"
                      tabindex="-1"
                      role="dialog"
                      aria-labelledby="deleteModalLabel"
                      aria-hidden="true"
                      v-if="deleteSelection"
                    >
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="deleteModalLabel">Game Delete</h5>
                            <button
                              type="button"
                              class="close"
                              data-dismiss="modal"
                              aria-label="Close"
                            >
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">Do you want to delete the game?</div>
                          <div class="modal-footer">
                            <button
                              type="button"
                              class="btn btn-secondary"
                              data-dismiss="modal"
                            >Close</button>
                            <button type="submit" class="btn btn-primary">Delete</button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </form>
                </div>

                <hr class="my-4" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import gameOps from "../js/GameRoutes";
import jwt from "jsonwebtoken";
export default {
  name: "profile",
  data() {
    return {
      account_type: "",
      username: "",
      email: "",
      imageData: "",
      game: {
        id_game: "",
        username: "",
        image: "",
        title: "",
        genre: "",
        publisher: "",
        developer: "",
        platform: "",
        released_on: "",
        multiplayer: "",
        description: "",
        video_link: ""
      },
      videoField: "",
      gamesLibrary: [],
      updateSelection: "",
      hideUpdate: true,
      deleteSelection: ""
    };
  },
  async created() {
    if (!this.$store.getters.isLoggedIn) {
      this.$router.push("/SignIn");
    }

    try {
      var decoded = jwt.verify(this.$store.getters.isLoggedIn, "SECRETKEY");
    } catch (err) {
      if (err.message == "jwt expired") {
        this.notify("Error!", "Session expired!", "error");
        this.$store.dispatch("logout");
        this.$router.push("/");
      }
    }

    this.account_type = this.$store.getters.getUser.account_type;
    this.username = this.$store.getters.getUser.username;
    this.email = this.$store.getters.getUser.email;
    //console.log("logged: " + this.$store.getters.logged);
  },
  mounted() {
    //cargar juegos
    this.loadLibrary();
  },
  methods: {
    //agrega juegos
    addGame(e) {
      e.preventDefault();
      this.game.username = this.username;
      this.game.video_link = this.videoSourceEmbed(this.videoField);
      //    console.log(this.game);

      var gameData = this.toFormData(this.game);

      try {
        (async () => {
          const response = await gameOps.addGame(gameData);
          this.message = response;

          //notify
          if (this.message.status == 409) {
            this.notify("Error!", this.message.message, "error");
          } else if (this.message.status == 200) {
            this.notify("Success!", this.message.message, "success");
            this.clearFields();
            this.gamesLibrary = [];
            this.loadLibrary();
          }
        })();
      } catch (error) {}
    },
    //carga los juegos
    async loadLibrary() {
      try {
        (async () => {
          const response = await gameOps.loadGames();

          if (response.status == 200) {
            response.gamesLibrary.forEach(game => {
              this.gamesLibrary.push(game);
            });
          } else {
            this.notify("Error!", this.message.message, "error");
          }
        })();
      } catch (error) {}
    },
    //actualiza los juegos
    updateGame(e) {
      e.preventDefault();
      this.game.video_link = this.videoSourceEmbed(this.videoField);

      var gameData = this.toFormData(this.game);

      try {
        (async () => {
          const response = await gameOps.updateGame(gameData);
          this.message = response;

          //notify
          if (this.message.status == 409) {
            this.notify("Error!", this.message.message, "error");
          } else if (this.message.status == 200) {
            this.notify("Success!", this.message.message, "success");
            this.clearFields();
            this.gamesLibrary = [];
            this.loadLibrary();
            this.hideUpdate = true;
            this.updateSelection = "";
          }
        })();
      } catch (error) {}
    },
    //borrar juego
    deleteGame(e) {
      e.preventDefault();
      var setGame = {
        id_game: this.deleteSelection
      };
      var tempGame = this.toFormData(setGame);

      try {
        (async () => {
          const response = await gameOps.deleteGame(tempGame);
          this.message = response;
          //notify
          if (this.message.status == 409) {
            this.notify("Error!", this.message.message, "error");
          } else if (this.message.status == 200) {
            this.notify("Success!", this.message.message, "success");
            this.gamesLibrary = [];
            this.loadLibrary();
            this.deleteSelection = "";
            $("#deleteModal").modal("hide");
          }
        })();
      } catch (error) {}
    },

    notifySelection() {
      if (!this.deleteSelection) {
        this.notify("Hey!", "A game must be selected", "warn");
      }
    },
    //selecciona el juego del select
    selectGame() {
      if (this.updateSelection) {
        this.hideUpdate = false;
        var selectedGame = "";
        this.gamesLibrary.forEach(game => {
          if (game.id_game == this.updateSelection) {
            selectedGame = game;
          }
        });

        this.setSelectedGame(selectedGame);
      } else {
        this.notify("Hey!", "A game must be selected", "warn");
      }
    },
    //Carga los valores del select al form
    setSelectedGame(selectedGame) {
      let multiplayer = 2;
      if (selectedGame.multiplayer == "YES") {
        multiplayer = 1;
      }

      this.game = {
        id_game: selectedGame.id_game,
        username: selectedGame.username,
        image: selectedGame.image,
        title: selectedGame.title,
        genre: selectedGame.genre,
        publisher: selectedGame.publisher,
        developer: selectedGame.developer,
        platform: selectedGame.platform,
        released_on: selectedGame.released_on,
        multiplayer: multiplayer,
        description: selectedGame.description,
        video_link: selectedGame.video_link
      };
      this.imageData = selectedGame.image;
      this.videoField = selectedGame.video_link;
      // console.log(this.game);
    },
    //cambia la ruta del video
    videoSourceEmbed(videoLink) {
      var link = "";
      if (videoLink.includes("youtube")) {
        if (!videoLink.includes("embed")) {
          var temp = videoLink.replace("https://www.youtube.com/watch?v=", "");
          link = "https://www.youtube.com/embed/" + temp + "?rel=0";
        } else {
          return videoLink;
        }
      } else if (videoLink.includes("vimeo")) {
        link = videoLink.replace(
          "https://vimeo.com/",
          "https://player.vimeo.com/video/"
        );
      } else if (videoLink.includes("dailymotion")) {
        link = videoLink.replace(
          "https://www.dailymotion.com/video/",
          "https://www.dailymotion.com/embed/video/"
        );
      } else {
        return videoLink;
      }
      return link;
    },
    //valida que solo se peudan digitar numeros y que no se pueda pegar
    validateNumbers(evt) {
      evt = evt ? evt : window.event;
      var charCode = evt.which ? evt.which : evt.keyCode;
      if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        evt.preventDefault();
      } else {
        return true;
      }
    },
    //para crear un ojeto form data para axios
    toFormData: function(obj) {
      var formData = new FormData();
      for (var key in obj) {
        formData.append(key, obj[key]);
      }

      return formData;
    },
    //limpia los espacios
    clearFields() {
      this.game = {
        image: "",
        title: "",
        genre: "",
        publisher: "",
        developer: "",
        platform: "",
        released_on: "",
        multiplayer: "",
        description: "",
        video_link: ""
      };
      this.imageData = "";
      this.videoField = "";
    },
    notify(title, text, type) {
      this.$notify({
        group: "foo",
        title: title,
        text: text,
        type: type
      });
    },
    logout() {
      this.$store.dispatch("logout");
      this.$router.push("/");
    },
    previewImage: function(event) {
      // Reference to the DOM input element
      var input = event.target;
      // Ensure that you have a file before attempting to read it
      if (input.files && input.files[0]) {
        // create a new FileReader to read this image and convert to base64 format
        var reader = new FileReader();
        // Define a callback function to run, when FileReader finishes its job
        reader.onload = e => {
          // Note: arrow function used here, so that "this.imageData" refers to the imageData of Vue component
          // Read image as base64 and set to imageData
          this.imageData = e.target.result;
          this.game.image = input.files[0];
        };
        // Start the reader job - read file as a data url (base64 format)
        reader.readAsDataURL(input.files[0]);
      }
    }
  }
};
</script>