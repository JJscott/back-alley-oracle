import { createApp } from 'vue'
import router from './router'
import store from './store'

// Component imports
import App from './App.vue'
import TheNavigationBar from '@/components/TheNavigationBar.vue'
import TheFooter from '@/components/TheFooter.vue'
import CardSymbol from '@/components/CardSymbol.vue'
import VueSelect from 'vue-select'

// Font Awesome imports
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { library } from '@fortawesome/fontawesome-svg-core'
import {
  faSearch, faHome, faUser,
  faUserPlus, faSignInAlt, faSignOutAlt
} from '@fortawesome/free-solid-svg-icons'
library.add(
  faSearch, faHome, faUser,
  faUserPlus, faSignInAlt, faSignOutAlt
);


// Create and mount app
const app = createApp(App);

// Register global components
app.component('the-navigation-bar', TheNavigationBar);
app.component('the-footer', TheFooter);
app.component('card-symbol', CardSymbol);
app.component('v-select', VueSelect);
app.component('fa', FontAwesomeIcon);

// Register vuex(store) and router
app.use(store);
app.use(router);

// Mount
app.mount('#app');
