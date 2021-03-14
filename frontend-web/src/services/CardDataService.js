import http from "../http-common";

class CardDataService {
  get(templateSid, cardId=null) {
    return http.get(`/cards/${templateSid}${cardId ? `?id=${cardId}` : ''}`);
  }

  getQuery({q, page=1, unique='', order=''}={}) {
    return http.get(`/cards/search?q=${q}&page=${page}`);
  }

  getRandom() {
    return http.get(`/cards/random`);
  }
}

export default new CardDataService();