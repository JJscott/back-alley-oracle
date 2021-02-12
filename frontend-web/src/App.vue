<template>
  <router-view/>
</template>

<script>
  import '@/css/bulma_style.scss'
  import '@/css/card_symbol.scss'

  export default {
    name: 'app'
  }


</script>

<style lang="scss">
html {
  background-image: url('./assets/pattern.png');
}

body {
  display: flex;
  min-height: 100vh;
  flex-direction: column;
}

// force footer to the bottom
#app {
  flex: 1;
  display: flex;
  flex-direction: column;
}
footer {
  margin-top: auto;
}
</style>

<!--
<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>
 -->