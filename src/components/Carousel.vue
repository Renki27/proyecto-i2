<template>
  <div
    id="carouselExampleIndicators"
    class="carousel slide carousel-fade animate__animated animate__fadeIn"
    data-ride="carousel"
  >
    <ol class="carousel-indicators">
      <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner" role="listbox">
      <!-- Slide One - Set the background image for this slide in the line below -->
      <div
        class="carousel-item active"
        style="background-image: url('https://images6.alphacoders.com/926/thumb-1920-926723.jpg')"
      >
        <div class="carousel-caption d-none d-md-block">
          <h3 class="display-4">Latest Releases</h3>
          <p class="lead">Keep up to date with the newest games.</p>
        </div>
      </div>
      <!-- Slide Two - Set the background image for this slide in the line below -->
      <div
        class="carousel-item"
        style="background-image: url('https://noticias.instacodez.com/wp-content/uploads/2017/06/The-Legend-of-Zelda-The-Breath-of-the-Wild-130617-001.jpg')"
      >
        <div class="carousel-caption d-none d-md-block">
          <h3 class="display-4">All Platforms</h3>
          <p class="lead">Games for all platforms.</p>
        </div>
      </div>
      <!-- Slide Three - Set the background image for this slide in the line below -->
      <div
        class="carousel-item"
        style="background-image: url('https://images.hdqwalls.com/download/coven-morgana-league-of-legends-4k-pn-1920x1080.jpg')"
      >
        <div class="carousel-caption d-none d-md-block">
          <h3 class="display-4">Games Descriptions</h3>
          <p class="lead">Full descriptions of the most relevant video games.</p>
        </div>
      </div>
    </div>
    <a
      class="carousel-control-prev"
      href="#carouselExampleIndicators"
      role="button"
      data-slide="prev"
    >
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a
      class="carousel-control-next"
      href="#carouselExampleIndicators"
      role="button"
      data-slide="next"
    >
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</template>

<script>
export default {
  name: "Carousel"
};
</script>
