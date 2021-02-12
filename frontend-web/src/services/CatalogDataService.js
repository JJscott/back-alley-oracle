import http from "../http-common";

class CatalogDataService {
  getCardNameCatalog() {
  	return http.get('/catalog/card-names');
  }

  getTypeCatalog() {
  	return http.get('/catalog/types');
  }

  getSubtypeCatalog() {
  	return http.get('/catalog/subtypes');
  }

  getClassCatalog() {
  	return http.get('/catalog/classes');
  }

  getSpecializationCatalog() {
  	return http.get('/catalog/specializations');
  }
}

export default new CatalogDataService();