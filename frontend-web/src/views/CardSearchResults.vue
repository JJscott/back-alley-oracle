<template>
  <the-navigation-bar />
  <div class="search-flex">
    <div>
      <card-search-feild v-bind:init="querySegment"></card-search-feild>
    </div>
    <div v-if="resultPages.length>0">
      <div>
        {{resultPages[0].totalCount}} results
        <ul v-if="resultPages[0].warnings">
          <li class="result-search-warning" v-for="warning in resultPages[0].warnings" :key="warning">>
            {{ warning }}
          </li>
        </ul>
      </div>

      <div v-for="(resultPage, index) in resultPages" :key="index">
        <p>Page {{index + 1}}</p>
        <div class="result-grid">
          <div class="result-grid-inner">
            <div class="result-grid-item" v-for="result in resultPage.data" :key="result.hash_id">
              <div v-if="result.object==='card'">
                <a v-bind:href="result.bao_uri">
                  <img v-bind:src="result.image_uris.normal">
                </a>
              </div>
              <div v-else-if="result.object==='cycle'">
                <p>cycle</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div v-if="loadMore" class="result-grid-loader">
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
      resultPages: [],
      loadMore: true
    };
  },
  computed: {
    querySegment() { return (this.$route.query.q) ? this.$route.query.q : ''; },
    uniqueSegment() { return (this.$route.query.unique) ? this.$route.query.unique : ''; }
  },
  methods: {
    fetchNextResultPage() {
      const q = this.querySegment;
      const u = this.uniqueSegment;
      if (q && this.loadMore) {
        CardDataService.getQuery({
          q: q,
          page: this.resultPages.length+1,
          unique: u
        })
          .then(response => {
            this.resultPages.push(response.data);
            this.loadMore = response.data.hasMore;
            // TODO load card/cycle page if only 1 result
            // if (this.resultPages[0].totalCount === 1) {
            //   this.$router.push({name:'card-view', params:{fcode: this.resultPages[0].data[0].fcode}});
            // }
          })
          .catch(e => {
            console.log(e);
          });
      }
    },
    scroll () {
      window.onscroll = () => {
        let bottomOfWindow = document.documentElement.scrollTop + window.innerHeight === document.documentElement.offsetHeight;
        if (bottomOfWindow) {
          this.fetchNextResultPage(this.$route.query.q);
        }
      };
    },
    refreshResultPages () {
      this.resultPages = [];
      this.loadMore = true;
      this.fetchNextResultPage();
    }
  },
  mounted() {
    this.fetchNextResultPage();
    this.scroll();
  },
  watch: {
    querySegment(newQuery) { this.refreshResultPages(); }
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

.result-grid {
  display: block;
  width: 100%;
}

.result-grid-inner {
  width: 100%;
  max-width: 1300px;
  margin: auto;
  position: relative;
  display: flex;
  flex-flow: row wrap;
  justify-content: center;
  align-content: center;
}

.result-grid-item {
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


.result-search-warning {
  color: red;
}


.result-grid-loader {
  .loader {
    margin: 3rem auto 5rem auto;
  }
}

</style>