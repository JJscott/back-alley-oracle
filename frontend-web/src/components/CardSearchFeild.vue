<template>
  <div>
    <div class="field has-addons">
      <div class="control is-expanded">
        <input class="input" type="text" placeholder="" v-model="searchQuery" v-on:keyup.enter="submitSearchQuery">
      </div>
      <div class="control">
        <a class="button is-info" type="button" @click="submitSearchQuery">
          <fa icon="search" />
        </a>
      </div>
    </div>


<!--     <div v-if="advancedsearch">
      <div v-show="showAvancedSearch">
        Input
        <card-class-select v-model="params.classes" />
      </div>
      <a v-on:click="toggleAvancedSearch()">Avanced Search</a>
    </div> -->
  </div>
</template>





<script>
import CatalogDataService from '@/services/CatalogDataService';
import CardClassSelect from '@/components/CardClassSelect';

export default {
  name: "card-search-feild",
  components: {
    CardClassSelect
  },
  props: {
    init: {
      type: String,
      default: ''
    },
    advancedsearch: {
      type: Boolean,
      default: true
    }
  },
  data() {
    return {
      searchQuery: this.init,
      showAvancedSearch: false,
      params: {
        classes: []
      }
    };
  },
  methods: {
    submitSearchQuery() {
      console.log('submit')
      if (this.searchQuery.length > 0) {
        this.$router.push({
          name: 'card-search',
          query: {
            q: this.searchQuery
          },
        });
      }
    },
    toggleAvancedSearch() {
      this.showAvancedSearch = !this.showAvancedSearch
    }
  },
  mounted() {

  }
};
</script>
