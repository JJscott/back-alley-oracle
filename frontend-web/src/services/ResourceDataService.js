import http from "../http-common";

class ResourceDataService {
  create(resourceName, data) {
    return http.post(`/resource/${resourceName}`, data);
  }

  getAll(resourceName) {
    return http.get(`/resource/${resourceName}`);
  }

  get(resourceName, id) {
    return http.get(`/resource/${resourceName}/${id}`);
  }

  update(resourceName, id, data) {
    return http.put(`/resource/${resourceName}/${id}`, data);
  }

  delete(resourceName, id) {
    return http.delete(`/resource/${resourceName}/${id}`);
  }

  deleteAll(resourceName) {
    return http.delete(`/resource/${resourceName}`);
  }
}

export default new ResourceDataService();