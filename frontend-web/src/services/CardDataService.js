import http from "../http-common";

class CardDataService {
  get(templateSid, cardId=null) {
    return http.get(`/cards/${templateSid}${cardId ? `?id=${cardId}` : ''}`);
  }

  getQuery({q, page=1, unique, order}={}) {
    const pageString = `&page=${page}`;
    const uniqueString = unique ? `&unique=${unique}`: '';
    const orderString = order ? `&order=${order}`: '';
    return http.get(`/cards/search?q=${q}${pageString}${uniqueString}${orderString}`);
  }

  getRandom() {
    return http.get(`/cards/random`);
  }
}

export default new CardDataService();