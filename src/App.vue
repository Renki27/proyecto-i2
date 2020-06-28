
<template>
  <div id="app">
    <!-- <Test msg="mensaje desde componente padre" />
    <User/>-->

    <Navbar />
    <router-view></router-view>
    <notifications group="foo" />
  </div>
</template>

<script>
import Navbar from "./components/Navbar.vue";

export default {
  name: "app",
  components: {
    Navbar
  }
};
</script>
