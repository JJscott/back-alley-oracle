<template>
<nav class="navbar is-dark" role="navigation" aria-label="main navigation">
  <div class="navbar-brand">
    <router-link :to="{name:'home'}" class="navbar-item">
      <img class="header-logo" src="../assets/squire-logo-white.png">
    </router-link>

    <a role="button" class="navbar-burger burger" aria-label="menu" aria-expanded="false" data-target="navbarBasicExample" @click="burgerOpen = !burgerOpen" :class="{'is-active': burgerOpen}">
      <span aria-hidden="true"></span>
      <span aria-hidden="true"></span>
      <span aria-hidden="true"></span>
    </a>
  </div>

  <div id="navbarBasicExample" class="navbar-menu" :class="{'is-active': burgerOpen}">
    <div class="navbar-start">
      <router-link :to="{name:'home'}" class="navbar-item">Home</router-link>
      <router-link to="" class="navbar-item">News</router-link>

      <div class="navbar-item has-dropdown is-hoverable">
        <router-link :to="{name:'card-search'}" class="navbar-link">Cards</router-link>
        <div class="navbar-dropdown">
          <router-link to="" class="navbar-item">Syntax Guide</router-link>
          <random-card-hyperlink class="navbar-item" />
        </div>
      </div>

      <div class="navbar-item has-dropdown is-hoverable">
        <a href class="navbar-link">Decks</a>
        <div class="navbar-dropdown">
          <router-link to="" class="navbar-item">Browse</router-link>
          <router-link to="" class="navbar-item">Search</router-link>
        </div>
      </div>
    </div>

    <current-user />
  </div>

</nav>
</template>





<script>
import CurrentUser from '@/components/CurrentUser.vue';
import RandomCardHyperlink from '@/components/RandomCardHyperlink.vue';

export default {
  name: "the-navagation-bar",
  data() {
    return {
      burgerOpen: false
    }
  },
  components : {
    CurrentUser,
    RandomCardHyperlink
  },
};
</script>





<style lang="scss">
nav.navbar.is-dark {
  background-color: #201500;
  box-shadow: 0 0 10px black;
}
</style>