<template>
  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-black" v-bind:key="loggedIn">
    <div class="container">
      <router-link class="navbar-brand" to="/">
        <strong>| GAMES LAB |</strong>
      </router-link>
      <button
        class="navbar-toggler"
        type="button"
        data-toggle="collapse"
        data-target="#navbarResponsive"
        aria-controls="navbarResponsive"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <router-link class="nav-link" to="/">Home</router-link>
          </li>
          <div class="navbar-nav ml-auto" v-if="!loggedIn">
            <li class="nav-item">
              <!-- <a class="nav-link" href="#">Sign Up</a> -->
              <router-link class="nav-link" to="/SignUp">Sign Up</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/SignIn">Sign in</router-link>
            </li>
          </div>

          <div v-else>
            <li class="nav-item">
              <!-- <a class="nav-link" href="#">Sign Up</a> -->
              <router-link class="nav-link" to="/Profile">My Account</router-link>
            </li>
          </div>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  name: "Navbar",
  data() {
    return {
      loggedIn: ""
    };
  },
  async mounted() {
    //this.loggedIn = this.$store.getters.isLoggedIn;
    this.isLoggedIn(this.$store.getters.isLoggedIn);
    console.log(this.loggedIn);
  },
  methods: {
    async isLoggedIn(session) {
      if (session) {
        this.loggedIn = true;
      } else {
        this.loggedIn = false;
      }
    }
  },
  computed: {
    session() {
      return this.loggedIn;
    }
  }
};
</script>