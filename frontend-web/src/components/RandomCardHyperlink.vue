<template>
  <a v-on:click="randomCard()">Random Card</a> 
</template>



<script>
import CardDataService from '@/services/CardDataService.js'

export default {
  name: "random-card-hyperlink",
  methods: {
    randomCard() {
      CardDataService.getRandom()
        .then(response => {
          const card = response.data;
          this.$router.push({name:'card-view', params:{cardId: card.id}});
          // this.$router.push(card.squireUri);
        })
        .catch(e => {
          console.log(e);
        });
    }
  }
};
</script>