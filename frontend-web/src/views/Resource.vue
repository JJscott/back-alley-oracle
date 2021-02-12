<template>
  <div>
    <the-navigation-bar />
    <div class="container content">

      <h1>Resource for {{resourceName}}</h1>

      <!-- Table layout for Classes -->
      <table>
        <thead>
          <tr>
            <!-- Auto generated headers -->
            <th>id</th>
            <th v-for="(column, index) in columnNames"> {{ column }} </th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <!-- Auto generated data -->
          <tr v-for="(rowdata, rowindex) in loadedData" :key="rowindex">
            <td>{{ rowdata.id }}</td>
            <td v-for="(column, colindex) in columnNames"> {{ rowdata[column] }} </td>
            <td>
              <button @click.prevent="editRow(rowdata)" class="button is-warning is-small">Edit</button>
              <button @click.prevent="deleteRow(rowdata)" class="button is-danger is-small">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Create/Edit Modal -->
      <div class="modal" :class="{'is-active': showModal}">
        <div class="modal-background"></div>
        <div class="modal-card">
          <header class="modal-card-head">
            <p class="modal-card-title">{{ (editMode ? 'Edit ' : 'Create ') }} {{ resourceName }}</p>
          </header>
          <section class="modal-card-body">
            <Form  id="edit-form" @submit="(editMode ? saveEditRow : saveNewRow)" v-slot="{ errors }">
              <!-- <resource-string-input -->
              <div v-for="(column, colindex) in columnNames">
                <label :for="column">{{column}}</label>
                <component
                  v-bind:is="columnTypes[colindex]"
                  :id="`${column}-input`"
                  :name="column"
                  v-model="editData[column]"
                />
                <ErrorMessage :name="column" class="resource-input-error" />
              </div>
            </Form>
          </section>
          <footer class="modal-card-foot">
            <button type="submit" form="edit-form" class="button is-success">Save changes</button>
            <button @click.prevent="showModal = false;" class="button">Cancel</button>
          </footer>
        </div>
      </div>

    </div>
  </div>
</template>





<script>
import { markRaw } from 'vue'
import ResourceDataService from "@/services/ResourceDataService";

import { Form, ErrorMessage } from 'vee-validate';
import ResourceStringInput from "@/components/ResourceStringInput";

export default {
  name: "card",
  components: {
    Form,
    ErrorMessage,
    ResourceStringInput
  },
  data() {
    return {
      // TODO make input values
      resource: {
        columnNames: []
        columnTypes: []
        resourceName: 'empty'  
      },

      loadedData: [],
      // add/edit
      newData: {},
      editData: {},
      editMode: false,
      showModal: false
    };
  },
  methods: {
    getData() {
      ResourceDataService.getAll(this.resourceName)
        .then(response => { this.loadedData = response.data; })
        .catch(e => { console.log(e); });
    },
    refresh() {
      this.getData();
    },
    newRow(form) {
      this.editData = {};
      for (col in this.columnNames) { this.newData['col'] = '' }
      this.editMode = false;
      this.showModal = true;
    },
    saveNewRow(form) {
      // TODO
      alert(JSON.stringify(form));
      this.refresh();
    },
    editRow(rowdata) {
      this.editData = rowdata; // load selected row
      this.editMode = true;
      this.showModal = true;
    },
    saveEditRow(form) {
      // TODO
      alert(JSON.stringify(form));
      this.refresh();
    },
    deleteRow(rowdata) {
      // TODO
      alert('DELETE THIS?!?!?!', JSON.stringify(rowdata));
      this.refresh();
    }
  },
  mounted() {

      // columnNames: ['class'],
      // columnTypes: [markRaw(ResourceStringInput)], // alternatively use shallowRef()
      // resourceName: 'cardClasses',

    this.refresh();
  }
};
</script>

