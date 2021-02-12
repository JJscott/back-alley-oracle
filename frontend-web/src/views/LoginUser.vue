<template>
  <the-navigation-bar />

  <div class="session">
    <Form class="session-form" @submit="onSubmitLogin" v-slot="{ errors }">

      <h1>Log into your Squire accout</h1>
      <div class="form-group">
        <label for="email" class="vh">Email</label>
        <Field as="input" v-model="email" type="email" name="email" :rules="emailRules" placeholder="Enter your email"/>
        <ErrorMessage name="email" />
      </div>

      <div class="form-group">
        <label for="password" class="vh">Password</label>
        <Field as="input" v-model="password" type="password" name="password" :rules="passwordRules" placeholder="Enter your password"/>
        <ErrorMessage name="password" />
      </div>

      <div class="form-group">
        <button class="button">Log In</button>
      </div>
    </Form>
  </div>

</template>





<script>
import { Form, Field, ErrorMessage } from 'vee-validate';
import * as yup from 'yup';

export default {
  name: 'Login',
  components: {
    Form,
    Field,
    ErrorMessage,
  },
  data() {
    return {
      email: '',
      password: '',
      loading: false,
      message: '',

      // TODO tidy up error messages and requirements
      emailRules: yup.string().required(),
      passwordRules: yup.string().required(),
    };
  },
  computed: {
    loggedIn() {
      return this.$store.state.auth.status.loggedIn;
    }
  },
  created() {
    if (this.loggedIn) {
      this.$router.push('/profile');
    }
  },
  methods: {
    onSubmitLogin(values) {
      this.loading = true;
      let user = {
        email: this.email,
        password: this.password
      };
      alert(JSON.stringify(values, null, 2));
      this.$store.dispatch('auth/login', user).then(
        () => {
          this.$router.push('/profile');
        },
        error => {
          this.loading = false;
          this.message =
            (error.response && error.response.data) ||
            error.message ||
            error.toString();
        }
      );
    }
  }
};
</script>





<style lang="scss">

.session {
  display: flex;
  flex-direction: column;
  justify-content: center;
  flex-wrap: nowrap;
  align-items: center;

  min-height: 100vh;
  padding: 40px 0 5% 0;
  background: linear-gradient(rgba(50,25,0,1), rgba(90,45,0,1));
}

.session-form {
  background-color: #221100;
  padding: 40px 0 26px 0;
  input {
    width: 90%;
    margin: 0 auto 0 auto;
    text-align: center;
  }
}


</style>