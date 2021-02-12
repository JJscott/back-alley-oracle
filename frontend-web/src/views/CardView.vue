<template>
  <the-navigation-bar />
  <main>
    <div class="inner-flex">
      <div class="card-profile" v-if="loadingCard">
        <p>Loading <br> TODO do something</p>
      </div>

      <div class="card-profile" v-else-if="card">
          <div class="columns is-tablet">

            <div class="column">
              <div class="card-image-container">
                <img :src="card.imageUris.png">
              </div>
            </div>

            <div class="column">
              <div class="card-text-box">
                <div :class="`pitch-bar-${card.pitch}`" ></div>

                <header class="card-title">
                  <h1 class="card-text-title">{{card.name}}</h1>
                </header>

                <div class="card-classtypes card-section">
                  <p>{{card.class}}</p>
                  <p>{{card.type}}</p>
                  <p class="" v-for="subtype in card.subtypes"> {{subtype}}</p>
                </div>

                <div class="card-symbol-section card-section" v-if="'pitch' in card || 'cost' in card">
                  <div v-if="'pitch' in card"><card-symbol :symbol="`p${card.pitch}`"/> {{card.pitch}}</div>
                  <div v-else></div>
                  <div v-if="'cost' in card">{{card.cost}} <card-symbol symbol="r"/></div>
                  <div v-else></div>
                </div>

                <div class="card-symbol-section card-section" v-if="'power' in card || 'intellect' in card || 'defense' in card || 'life' in card">
                  <div v-if="'power' in card"><card-symbol symbol="p"/> {{card.power}}</div>
                  <div v-else-if="'intellect' in card"><card-symbol symbol="i"/> {{card.intellect}}</div>
                  <div v-else></div>
                  <div v-if="'defense' in card">{{card.defense}} <card-symbol symbol="d"/></div>
                  <div v-else-if="'life' in card">{{card.life}} <card-symbol symbol="h"/></div>
                  <div v-else></div>
                </div>

                <div class="card-text card-section" v-if="card.rulesText">
                  <p v-html="cardText" />
                </div>

                <div class="card-text card-section" v-if="card.flavorText">
                  <p v-html="card.flavorText" />
                </div>

                <div class="card-text card-section" v-if="card.rulesText">
                  <p>{{card.rarityName}}</p>
                  <p>{{card.code}}</p>
                  <p>Illustrated by {{card.artistName}}</p>
                </div>
              </div>
            </div>

            <div class="column">

              <div class="card-print-box">
                <div class="card-print-header">
                  <h2>{{card.setName}} ({{card.setCode}})</h2>
                  <p>#{{`${card.setNumber}`.padStart(3, '0')}} - {{card.rarityName}}</p>
                </div>
                <div class="" v-if="cardPrints">
                  <table class="fixed-table-header">
                    <thead>
                      <tr>
                        <td>Print</td>
                        <td>NZD</td>
                        <td>EUR</td>
                        <td>USD</td>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="print in cardPrints">
                        <td>{{print.setName}}</td>
                        <td>0.69</td>
                        <td>0.69</td>
                        <td>0.69</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

              <div class="" v-if="cardCycles">
                <p>Cycles</p>
                <div class="card-cycle" :class="`pitch-bar-${cycle.pitch}`" v-for="cycle in cardCycles">
                  {{cycle.name}}
                </div>
              </div>
            </div>

          </div>
      </div>

      <div v-else>
        <p>No card found <br> TODO do something</p>
      </div>

    </div>
  </main>
  <the-footer />
</template>





<script>
import CardSymbolParser from "@/components/CardSymbolParser";
import CardDataService from "@/services/CardDataService";

export default {
  name: "card",
  data() {
    return {
      loadingCard: true,
      card: null,
      cardText: '',
      cardCycles: null,
      cardPrints: null,
    };
  },
  computed: {
    cardIdSegment() {
      return (this.$route.params.cardId) ? this.$route.params.cardId : '';
    }
  },
  methods: {
    getCard(cardId) {
      // card
      this.loadingCard = true;
      CardDataService.get(cardId)
        .then(response => {
          this.card = response.data;
          if (this.card && this.card.rulesText) {
            this.cardText = CardSymbolParser(this.card.rulesText);
          }
          this.loadingCard = false;

          // set hashbang equal to templateSid
          const uriHash = `#!${this.card.templateSid}`;
          if (this.$route.hash !== uriHash) {
            this.$router.replace({
              path: this.$route.path,
              hash: `#!${this.card.templateSid}`
            });
          }


          // // prints
          // CardDataService.getPrints(this.card.pname)
          //   .then(response => {this.cardPrints = response.data;})
          //   .catch(e => {console.log(e);});

          // // cycles
          // CardDataService.getCycles(this.card.cname)
          //   .then(response => {
          //     this.cardCycles = response.data;
          //     this.cardCycles.sort((a,b) => {return a.pitch - b.pitch});
          //   })
          //   .catch(e => {console.log(e);});
            
        })
        .catch(e => {
          console.log(e);
        });
    }
  },
  mounted() {
    this.getCard(this.$route.params.cardId);
  },
  watch: {
    cardIdSegment(newCardId) {
      if (newCardId) {
        this.getCard(newCardId);
      }
    }
  }
};
</script>




<style lang="scss">
@import "@/css/custom_colors.scss";

.card-profile {
  padding: 1rem;
  background: white;
  box-shadow: 0 0 10px black;
}

.card-image {
  border-radius: 15px;
  filter: drop-shadow(2px 2px 2px #555); 
  width: 200px;
}

.card-image-container {
  position: relative;
}

.card-text-box{
  border: solid grey 1px;
  border-radius: 0.5rem;
  // filter: drop-shadow(2px 2px 2px #555); 
  box-shadow: 0 0 10px grey;
  overflow: hidden;
}

.card-section {
  border-top: 1px solid grey;
  padding: 0.5rem 1rem 0.5rem 1rem;
}

.card-title {
  h1 {
    font-size: 2rem;
    text-align: center;
  }
}

.card-classtypes {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

.card-symbol-section {
  font-size: 2rem;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  padding: 0 1rem 0 1rem;
}

.card-print-box{
  border: solid black 1px;
}

.card-print-header{
  background-color: #333;
  color: white;
  h2 {
    font-size: 1.5rem;
  }
}

.fixed-table-header{
  tbody {
    // display:block;
    overflow:auto;
  //   // max-height:200px;
    width:100%;
  }
  thead tr{
    // display:block;
  }
}

.pitch-bar-undefined {
  border-top: 10px solid grey;
}

.pitch-bar-1 {
  border-top: 10px solid $pitch-red;
}

.pitch-bar-2 {
  border-top: 10px solid $pitch-yellow;
}

.pitch-bar-3 {
  border-top: 10px solid $pitch-blue;
}

</style>