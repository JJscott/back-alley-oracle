<template>
  <main class="homepage">
    <div class="inner-flex">
      <header class="homepage-header">
        <img class="homepage-logo" src="../assets/squire-logo-white.png" alt="Squire logo">
        <h1 class="homepage-title">A card search tool for the <strong>Flesh and Blood</strong> card game</h1>
      </header>
      <card-search-feild class="homepage-form" />
      <div class="homepage-links">
        <a class="button">Syntax Guide</a>
        <random-card-hyperlink class="button" />
      </div>
    </div>
  </main>
  <the-footer />
</template>



<script>
import CardSearchFeild from '@/components/CardSearchFeild.vue'
import CurrentUser from '@/components/CurrentUser.vue';
import RandomCardHyperlink from '@/components/RandomCardHyperlink.vue';

export default {
  name: "landing-page",
  components: {
    CardSearchFeild,
    CurrentUser,
    RandomCardHyperlink
  }
};
</script>



<style lang="scss">
@import "@/css/util.scss";

.homepage {
  text-align: center;
  background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.1));
}

.homepage .inner-flex {
  min-height: px-to-rem(600px);
  height: 100vh;
  justify-content: center;
  align-items: center;
}

.homepage-title {
  font-size: 1.5rem;
  font-weight: 200;
  color: #FDFDFD;
  margin-bottom: 1rem;
  strong {
    font-weight: 400;
    color: #FDFDFD;
  }
}

.homepage-logo {
  width:400px;
}

.homepage-form {
  margin: 20px auto 0;
  width: 100%;
  max-width: 600px;
}

.homepage-links {
  width: 100%;
  margin: 20px auto 0 auto;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;

  a {
    margin: 0 10px;
    font-size: 12px;
  }
}
</style>