<template>
  <div class="card card-container">
    <img
      id="profile-img"
      src="//ssl.gstatic.com/accounts/ui/avatar_2x.png"
      class="profile-img-card"
    />

    <Form @submit="onSubmitRegister" v-slot="{ errors }">
      <div class="form-group">
        <label for="username">Username</label>
        <Field as="input" v-model="username" type="text" name="username" :rules="usernameRules" />
        <ErrorMessage name="username" />
      </div>

      <div class="form-group">
        <label for="email">Email</label>
        <Field as="input" v-model="email" type="email" name="email" :rules="emailRules" />
        <ErrorMessage name="email" />
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <Field as="input" v-model="password" type="password" name="password" :rules="passwordRules" />
        <ErrorMessage name="password" />
      </div>

      <div class="form-group">
        <button class="button">Register</button>
      </div>
    </Form>
  </div>



<!--     <form name="form" @submit.prevent="handleRegister">
      <div v-if="!successful">
        <div class="form-group">
          <label for="username">Username</label>
          <input
            v-model="username"
            v-validate="'required|min:3|max:20'"
            type="text"
            class="form-control"
            name="username"
          />
          <div
            v-if="submitted && errors.has('username')"
            class="alert-danger"
          >{{errors.first('username')}}</div>
        </div>
        <div class="form-group">
          <label for="email">Email</label>
          <input
            v-model="email"
            v-validate="'required|email|max:50'"
            type="email"
            class="form-control"
            name="email"
          />
          <div
            v-if="submitted && errors.has('email')"
            class="alert-danger"
          >{{errors.first('email')}}</div>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input
            v-model="password"
            v-validate="'required|min:6|max:40'"
            type="password"
            class="form-control"
            name="password"
          />
          <div
            v-if="submitted && errors.has('password')"
            class="alert-danger"
          >{{errors.first('password')}}</div>
        </div>
        <div class="form-group">
          <button class="btn btn-primary btn-block">Sign Up</button>
        </div>
      </div>
    </form>

    <div
      v-if="message"
      class="alert"
      :class="successful ? 'alert-success' : 'alert-danger'"
    >{{message}}</div>
  </div> -->
</template>





<script>
import { Form, Field, ErrorMessage } from 'vee-validate';
import * as yup from 'yup';

export default {
  name: 'Register',
  components: {
    Form,
    Field,
    ErrorMessage,
  },
  data() {
    return {
      username: '',
      email: '',
      password: '',
      submitted: false,
      successful: false,
      message: '',

      // TODO tidy up error messages and requirements
      usernameRules: yup.string().required().min(3).max(20),
      emailRules: yup.string().required().email().max(100),
      passwordRules: yup.string().required().min(8).max(100),
    };
  },
  computed: {
    loggedIn() {
      return this.$store.state.auth.status.loggedIn;
    }
  },
  mounted() {
    if (this.loggedIn) {
      this.$router.push('/profile');
    }
  },
  methods: {
    onSubmitRegister(values) {
      this.message = '';
      this.submitted = true;
      let user = {
        username: this.username,
        email: this.email,
        password: this.password
      };
      alert(JSON.stringify(values, null, 2));
      this.$store.dispatch('auth/register', user).then(
        data => {
          this.message = data.message;
          this.successful = true;
        },
        error => {
          this.message =
            (error.response && error.response.data) ||
            error.message ||
            error.toString();
          this.successful = false;
        }
      );
    },

    handleRegister() {

    }

  }
};
</script>





<style>

</style>