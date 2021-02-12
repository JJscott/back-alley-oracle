<template>
  <span v-html="symbolHtml" />
</template>



<script>
import CardSymbolParser from "@/components/CardSymbolParser";

//TODO need to deal with dynamic binding for symbol?
export default {
  name: "card-symbol",
  props: {
    symbol: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      symbolHtml: ''
    }
  },
  mounted() {
    this.symbolHtml = CardSymbolParser(`{${this.symbol}}`);
  }
};
</script>