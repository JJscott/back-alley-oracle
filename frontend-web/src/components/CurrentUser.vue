<template>
  <div v-if="!currentUser" class="navbar-end">
    <router-link :to="{name:'register'}" class="navbar-item"><fa icon="user-plus" /> Register</router-link>
    <router-link :to="{name:'login'}" class="navbar-item"><fa icon="sign-in-alt" /> Log In</router-link>
  </div>
  <div v-if="currentUser" class="navbar-block navbar-end">
    <div class="navbar-item has-dropdown is-hoverable">
      <a class="navbar-link"><fa icon="user" />{{currentUser.username}}</a>
      <div class="navbar-dropdown">
        <a class="navbar-item">TODO</a>
        <a class="navbar-item">TODO</a>
        <hr class="navbar-divider">
        <a class="navbar-item">TODO</a>
      </div>
    </div>
    <a class="navbar-item" href @click.prevent="logOut"><fa icon="sign-out-alt" />Log Out</a>
  </div>
</template>

<script>
export default {
  name: "current-user",
  computed: {
    currentUser() {
      return this.$store.state.auth.user;
    },
  },
  methods: {
    logOut() {
      this.$store.dispatch('auth/logout');
      this.$router.push('/login');
    }
  }
};
</script>


<style lang="scss">
  .navbar-block {
    // display: inline-flex;
    // flex-flow: row nowrap
  }
</style>
