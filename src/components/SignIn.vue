<template>
  <div class="container-fluid bg-landscape">
    <div class="container h-100 animate__animated animate__fadeInDown animate_slow">
      <div class="row h-100 justify-content-center align-items-center">
        <div class="col-lg-10 col-xl-9 mx-auto">
          <div class="card card-signin cover1 flex-row my-5">
            <div class="card-img-left d-none d-md-flex">
              <!-- Background image for card set in CSS! -->
            </div>
            <div class="card-body">
              <h5 class="card-title text-center">Sign in</h5>
              <hr class="my-4" />

              <form class="form-signin mt-100" v-on:submit="handleSubmit">
                <div class="form-label-group">
                  <input
                    type="text"
                    id="inputUserame"
                    class="form-control"
                    placeholder="Username"
                    name="username"
                    v-model="user.username"
                    required
                    autofocus
                  />
                  <label for="inputUserame">Username</label>
                </div>

                <div class="form-label-group mt-4">
                  <input
                    type="password"
                    id="inputPassword"
                    class="form-control"
                    placeholder="Password"
                    name="password"
                    v-model="user.password"
                    required
                  />
                  <label for="inputPassword">Password</label>
                </div>

                <button
                  class="btn btn-lg btn-primary btn-block text-uppercase mt-50"
                  type="submit"
                >Sign in</button>

                <router-link class="d-block text-center mt-4 medium color-black" to="/SignUp">
                  <strong>CREATE ACCOUNT?</strong>
                </router-link>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import jwt from "jsonwebtoken";
import Authentication from "../js/Authentication.js";
export default {
  name: "sign-in",
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      userExists: "",
      userPayload: {
        account_type: "",
        username: "",
        email: ""
      },
      errorMessage: ""
    };
  },
  //Si el usuario está logueado no tiene acceso
  async created() {
    if (this.$store.getters.isLoggedIn) {
      this.$router.push("/Profile");
    }
  },
  methods: {
    //USAR THIS. EN LOS METODOS O NO SIRVE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    async handleSubmit(submitEvent) {
      submitEvent.preventDefault(); //previene el default submit del form
      try {
        (async () => {
          //verificar que el usuario existe
          const response = await Authentication.verifyUser(this.user.username);
          this.userExists = response;
          if (this.userExists == 0) {
            this.notify(
              "Error!",
              "Account doesn't exist or wrong data!",
              "error"
            );
          } else {
            const userData = this.toFormData(this.user); //crea el formData
            const response = await Authentication.login(userData);
            // si los datos son erroneos
            if (response.error) {
              this.errorMessage = response.message;
              this.notify("Error!", this.errorMessage, "error");
              //login
            } else {
              this.notify(
                "Success!",
                "Welcome, " + this.user.username,
                "success"
              );
              //crea el payload
              this.userPayload.account_type = response.user.account_type;
              this.userPayload.username = response.user.username;
              this.userPayload.email = response.user.email;

              //crea el token de sesión
              var token = jwt.sign(
                {
                  account_type: this.userPayload.account_type,
                  username: this.userPayload.username,
                  email: this.userPayload.email
                },
                "SECRETKEY",
                {
                  expiresIn: "1h"
                }
              );
              const user = this.userPayload;
              this.$store.dispatch("login", { token, user });
              this.$router.push("/Profile");
            }
          }
        })();
      } catch (error) {
        console.log(error);
      }
    },
    //para crear un ojeto form data para axios
    toFormData(obj) {
      var formData = new FormData();
      for (var key in obj) {
        formData.append(key, obj[key]);
      }
      return formData;
    },

    notify(title, text, type) {
      this.$notify({
        group: "foo",
        title: title,
        text: text,
        type: type
      });
    }
  }
};
</script>