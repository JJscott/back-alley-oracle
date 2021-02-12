import http from "@/http-common";

class AuthService {
  register(user) {
    return http.post('user/register', {
      username: user.username,
      email: user.email,
      password: user.password
    });
  }

  login(user) {
    return http.post('user/login', {
      email: user.email,
      password: user.password
    }).then(response => {
        // record access token
        if (response.data.accessToken) {
          localStorage.setItem('user', JSON.stringify(response.data));
        }
        return response.data;
      });
  }

  logout() {
    localStorage.removeItem('user');
  }
}

export default new AuthService();