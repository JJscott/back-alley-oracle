<template>
  <Field
    as="input"
    type="text"
    :id="id"
    :name="name"
    :class="class"
    :rules="stringRules"
    v-model="modelValue"
  />
</template>



<script>
import { Field } from 'vee-validate';
import * as yup from 'yup';

export default {
  name: 'resource-string-input',
  props: {
    id: {type: String, required: true},
    name: {type: String, required: true},
    class: {type: String, default: ""},
    modelValue: {type: String},
  },
  components: {
    Field
  },
  data() {
    return {
      stringRules: yup.string().required(),
    };
  },
};
</script>