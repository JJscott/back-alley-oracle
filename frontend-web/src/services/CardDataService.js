import http from "../http-common";

class CardDataService {
  get(cardId) {
    return http.get(`/cards/${cardId}`);
  }

  getQuery({q, page=1, unique='', order=''}={}) {
    return http.get(`/cards/search?q=${q}&page=${page}`);
  }

  // getCycles(cname) {
  //   return http.get(`/cards/cycles/${cname}`);
  // }

  // getPrints(pname) {
  //   return http.get(`/cards/prints/${pname}`);
  // }

  getRandom() {
    return http.get(`/cards/random`);
  }
}

export default new CardDataService();