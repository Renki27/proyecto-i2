<template>
  <div class="container-fluid">
    <div class="row h-100 justify-content-center align-items-center">
      <div class="col">
        <h1 class="display-1 text-center">Oops!, Page not found!</h1>
        <p
          class="display-4 sec-title text-center lead color-red"
        >redirecting in {{timerCount}} seconds</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      timerCount: 5
    };
  },

  watch: {
    timerCount: {
      handler(value) {
        if (value > 0) {
          setTimeout(() => {
            this.timerCount--;
          }, 1000);
        } else {
          this.$router.push("/");
        }
      },
      immediate: true // This ensures the watcher is triggered upon creation
    }
  }
};
</script>