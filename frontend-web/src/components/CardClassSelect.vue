<template>
  <select multiple="true" v-model="modelValue">
    <option v-for="cardClass in cardClasses" :value="cardClass.value">{{cardClass.text}}</option>
  </select>
</template>

<script>
import CatalogDataService from '@/services/CatalogDataService';

export default {
  name: "card-class-select",
  props: {
    modelValue: Array
  },
  data() {
    return {
      cardClasses: null,
      selectedClass: null
    };
  },
  // methods: {
  //   changePageTitle(title) {
  //     this.$emit('update:modelValue', title)
  //   }
  // }
  mounted() {
    CatalogDataService.getClassCatalog()
      .then(response => {
        const classes = response.data.data.sort();
        this.cardClasses = classes.map(entry => {
          return {
            value: entry,
            text: entry
          };
        });
      })
      .catch(e => {
        console.log(e);
      });
  }
};
</script>