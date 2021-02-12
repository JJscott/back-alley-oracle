<template>
  <the-navigation-bar />
  <div class="search-flex">
    <div>
      <card-search-feild v-bind:init="queryString"></card-search-feild>
    </div>
    <div v-if="cardPages.length>0">
      <div>
        {{cardPages[0].totalCount}} results
        <ul v-if="cardPages[0].warnings">
          <li class="card-search-warning" v-for="warning in cardPages[0].warnings" :key="warning">>
            {{ warning }}
          </li>
        </ul>
      </div>

      <div v-for="(cardPage, index) in cardPages" :key="index">
        <p>Page {{index + 1}}</p>
        <div class="card-grid">
          <div class="card-grid-inner">
            <div class="card-grid-item" v-for="card in cardPage.data" :key="card.fcode">
              <a v-bind:href="card.squireUri">
                <img v-bind:src="card.imageUris.normal">
              </a>
            </div>
          </div>
        </div>
      </div>
      <div v-if="loadMore" class="card-grid-loader">
        <div class="loader"></div>
      </div>

    </div>
    <div v-else>
      <!-- //TODO -->
    </div>

  </div>
  <the-footer />
</template>





<script>
import CardDataService from '@/services/CardDataService';
import CardSearchFeild from '@/components/CardSearchFeild.vue';

export default {
  name: "card-search",
  components: {
    CardSearchFeild
  },
  data() {
    return {
      message: '',
      cardPages: [],
      loadMore: true
    };
  },
  computed: {
    queryString() {
      return (this.$route.query.q) ? this.$route.query.q : '';
    }
  },
  methods: {
    fetchNextCardPage(q) {
      if (q && this.loadMore) {
        CardDataService.getQuery({
          q: q,
          page: this.cardPages.length+1
        })
          .then(response => {
            this.cardPages.push(response.data);
            this.loadMore = response.data.hasMore;
            // load card page if only 1 result
            if (this.cardPages[0].totalCount === 1) {
              this.$router.push({name:'card-view', params:{fcode: this.cardPages[0].data[0].fcode}});
            }
          })
          .catch(e => {
            console.log(e);
          });
      }
    },
    scroll (person) {
      window.onscroll = () => {
        let bottomOfWindow = document.documentElement.scrollTop + window.innerHeight === document.documentElement.offsetHeight;
        if (bottomOfWindow) {
          this.fetchNextCardPage(this.$route.query.q);
        }
      };
    }
  },
  mounted() {
    this.fetchNextCardPage(this.queryString);
    this.scroll();
  },
  watch: {
    queryString(newQuery) {
      this.cardPages = [];
      this.loadMore = true;
      if (newQuery) {
        this.fetchNextCardPage(newQuery);
      }
    }
  }
};
</script>





<style lang="scss">


.search-flex{
  margin: 0 auto;
  width: 100%;
  max-width: 1300px;
  position: relative;
  display: flex;
  flex-flow: column nowrap;
  background-color: white;
}

.card-grid {
  display: block;
  width: 100%;
}

.card-grid-inner {
  width: 100%;
  max-width: 1300px;
  margin: auto;
  position: relative;
  display: flex;
  flex-flow: row wrap;
  justify-content: center;
  align-content: center;
}

.card-grid-item {
  width: 240px;
  font-size: 0px;
  margin: 5px;
  border-radius: 15px;
  overflow: hidden;
  filter:drop-shadow(2px 2px 2px #000000BB);
  a {
    :hover {
        border: 3px solid red;
        border-radius: 20px;
    }
  };
}


.card-search-warning {
  color: red;
}


.card-grid-loader {
  .loader {
    margin: 3rem auto 5rem auto;
  }
}

</style>