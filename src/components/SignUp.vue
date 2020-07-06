<template>
  <div class="container-fluid bg-landscape">
    <div class="container h-100 animate__animated animate__fadeInDown animate_slow">
      <div class="row h-100 justify-content-center align-items-center">
        <div class="col-lg-10 col-xl-9 mx-auto">
          <div class="card card-signin cover2 flex-row my-5">
            <div class="card-img-left d-none d-md-flex">
              <!-- Background image for card set in CSS! -->
            </div>
            <div class="card-body">
              <h5 class="card-title text-center">Register</h5>

              <form class="form-signin" v-on:submit="signUp">
                <!--                 <div class="form-label-group">
                  <select
                    name="account_type"
                    class="custom-select custom-select-lg mb-3"
                    v-model="user.account_type"
                    required
                    hidden
                  >
                    <option selected default value disabled>Choose...</option>
                    <option value="1">Administrator</option>
                    <option value="2">User</option>
                  </select>
                </div>-->

                <hr class="my-4" />

                <div class="form-label-group">
                  <input
                    type="text"
                    id="inputUserame"
                    class="form-control"
                    placeholder="Username"
                    name="username"
                    v-model.trim="user.username"
                    required
                    autofocus
                  />
                  <label for="inputUserame">Username</label>
                </div>

                <div class="form-label-group">
                  <input
                    type="email"
                    id="inputEmail"
                    class="form-control"
                    placeholder="Email address"
                    name="email"
                    v-model.trim="user.email"
                    required
                  />
                  <label for="inputEmail">Email address</label>
                </div>

                <div class="form-label-group">
                  <input
                    type="password"
                    id="inputPassword"
                    class="form-control"
                    placeholder="Password"
                    name="password"
                    v-model.trim="user.password"
                    required
                  />
                  <label for="inputPassword">Password</label>
                </div>

                <div class="form-label-group">
                  <input
                    type="password"
                    id="inputConfirmPassword"
                    class="form-control"
                    placeholder="Password"
                    name="password_confirm"
                    v-model.trim="user.password_confirm"
                    required
                  />
                  <label for="inputConfirmPassword">Confirm password</label>
                </div>

                <button class="btn btn-lg btn-primary btn-block text-uppercase mt-50" type="submit">
                  Create
                  my Account!
                </button>
                <router-link class="d-block text-center mt-4 medium color-black" to="/SignIn">
                  <strong>ALREADY HAVE AN ACCOUNT?</strong>
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
import Authentication from "../js/Authentication.js";
import Verification from "../js/UserMiddleware";
export default {
  name: "sign-up",
  data() {
    return {
      user: {
        account_type: "",
        username: "",
        email: "",
        password: "",
        password_confirm: ""
      },
      message: "",
      validationRes: ""
    };
  },
  async created() {
    if (this.$store.getters.isLoggedIn) {
      this.$router.push("/Profile");
    }
  },
  methods: {
    async signUp(submitEvent) {
      try {
        submitEvent.preventDefault();
        this.user.account_type = 1; //de momento solo hay admins
        var userData = this.toFormData(this.user);
        this.validationRes = Verification.validateUser(this.user); //   *****************validación antes del submit
        if (this.validationRes.length) {
          this.$notify({
            group: "foo",
            title: "Error!",
            text: this.validationRes,
            type: "error"
          });
        } else {
          //para optener el response al ser async
          (async () => {
            const response = await Authentication.createAccount(userData);
            this.message = response;
            console.log(this.message);

            //notify
            if (this.message.status == 409) {
              this.notify("Error!", this.message.message, "error");
            } else if (this.message.status == 200) {
              this.notify(
                "Success!",
                "Welcome, " + this.message.message,
                "success"
              );
              this.clearFields();
            }
          })();
        }
      } catch (error) {
        console.log(error);
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
    clearFields() {
      this.user = {
        account_type: "",
        username: "",
        email: "",
        password: "",
        password_confirm: ""
      };
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