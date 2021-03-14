import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  // {
  //   path: "/",
  //   alias: "/tutorials",
  //   name: "tutorials",
  //   component: () => import("@/components/TutorialsList")
  // },
  // {
  //   path: "/tutorials/:id",
  //   name: "tutorial-details",
  //   component: () => import("@/components/Tutorial")
  // },
  // {
  //   path: "/add",
  //   name: "add",
  //   component: () => import("@/components/AddTutorial")
  // },
  {
    path: "/",
    name: "home",
    component: () => import("@/views/Home")
  },
  {
    path: "/cards/search",
    name: "card-search",
    component: () => import("@/views/CardSearchResults")
  },
  {
    path: "/cards/:templateSid",
    name: "card-view",
    component: () => import("@/views/CardView")
  },
  // {
  //   path: "/resources/class",
  //   name: "resource-class-view",
  //   component: () => import("@/views/resources/Class")
  // },


  {
    path: "/register",
    name: "register",
    component: () => import("@/views/RegisterUser")
  },
  {
    path: "/login",
    name: "login",
    component: () => import("@/views/LoginUser")
  },
  {
    path: "/profile",
    name: "profile",
    component: () => import("@/views/UserProfile")
  },




  // {
  //   path: "/resources/:",
  //   name: "resources-class",
  //   component: () => import("@/views/resources/Class")
  // },


  {
    path: "/test",
    name: "test",
    component: () => import("@/views/Test")
  }
]

      // columnNames: ['class'],
      // columnTypes: [markRaw(ResourceStringInput)], // alternatively use shallowRef()
      // resourceName: 'cardClasses',

const router = createRouter({
  history: createWebHistory(),
  routes
})


export default router
