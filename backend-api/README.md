# Setup

Install npm.

## Create an `.env` file (set enviroment variables)

Create a `.env` file in the root of the project, filling out the following appropriately:
```js
PORT=8080
PSQL_HOST='localhost'
PSQL_USER='username'
PSQL_PASSWORD='password'
PSQL_DB='database'
DATABASE_URL='postgres://username:password@localhost:5432/database?sslmode=disable'
API_URL='http://localhost:8080/'
IMG_URL='https://img.backalleyoracle.com/'
WEB_URL='http://localhost:8081/'
```

## Migrate and initilize the database


First migrate the database using `dbmate`.

```
> dbmate up
```

Then seed the database with card data using

```
> npx knex seed:run
```

# To run

`npm run dev`
`npm run start`


## Docker

```bash
$ docker build -t backend-api .
$ docker images --filter reference=backend-api
$ docker tag backend-api:latest 894336578105.dkr.ecr.ap-southeast-2.amazonaws.com/back-alley-oracle:backend-api-latest
$ docker push 894336578105.dkr.ecr.ap-southeast-2.amazonaws.com/back-alley-oracle:backend-api-latest


```


# notes:
```sql
WITH cardPrints
AS (SELECT *, ROW_NUMBER() OVER (
		PARTITION BY cardId 
		ORDER BY releaseDate DESC) row_num
	FROM prints)
SELECT *
FROM cardPrints
JOIN cards ON cardPrints.cardId = cards.id
LEFT JOIN cardClasses ON cards.cardClassId = cardClasses.id
LEFT JOIN cardSpecializations ON cards.cardSpecializationId = cardSpecializations.id
LEFT JOIN cardTypes ON cards.cardTypeId = cardTypes.id
LEFT JOIN cardSubtypes ON cards.cardSubtypeId = cardSubtypes.id
LEFT JOIN printArtists ON cardPrints.printArtistId = printArtists.id
LEFT JOIN printFoils ON cardPrints.printFoilId = printFoils.id
LEFT JOIN printRarities ON cardPrints.printRarityId = printRarities.id
LEFT JOIN printSets ON cardPrints.printSetId = printSets.id
WHERE row_num = 1;
```

## Stores
Noteable online stores:
https://fabempire.com/ REDDIT10
https://cardmerchant.co.nz/
https://fabarmory.com/ Sam smith
https://www.rathe.shop/
https://www.calicokeep.com/collections/fab-singles
https://hobbymaster.co.nz/cards/37


## static files:
https://expressjs.com/en/starter/static-files.html


| Code | Status | Description |
|---|---|---|
| 200 | OK | The request was successfully completed. |
| 201 | Created | A new resource was successfully created. |
| 400 | Bad Request | The request was invalid. |
| 401 | Unauthorized | The request did not include an authentication token or the authentication token was expired. |
| 403 | Forbidden | The client did not have permission to access the requested resource. |
| 404 | Not Found | The requested resource was not found. |
| 405 | Not Allowed | The HTTP method in the request was not supported by the resource. For example, the DELETE method cannot be used with the Agent API. |
| 409 | Conflict | The request could not be completed due to a conflict. For example,  POST ContentStore Folder API cannot complete if the given file or folder name already exists in the parent location. |
| 500 | Internal Error | The request was not completed due to an internal error on the server side. |
| 503 | Unavailable | The server was unavailable. |



### Fuzzy string searching:
 - https://fusejs.io/



# TODO
 - numeric search parameters to deal with null (searching for cards without a cost etc.)
 - optimize SQL queries (espeically the same query over again)
 - fuzzy string card search
 - add timestamps to all data? (is this nessesary)
 - generate other image URIs for card.controller.js
 - make unique an option rather than mandatory



# Notes
	
MySQL needs to be setup with ngram_token_size=3

For fuzzy search Could possiblly use:
	https://dev.mysql.com/doc/refman/8.0/en/udf-loading.html
	https://github.com/juanmirocks/Levenshtein-MySQL-UDF
Or
http://web.archive.org/web/20081120113322/http://blog.lolyco.com/sean/wp-content/uploads/2008/08/damlevlim2561.cpp
http://web.archive.org/web/20080923030427/http://blog.lolyco.com/sean/2008/08/06/search-suggestions-with-mysql-levenshtein-distance/


### Possabillly add?
```
const helmet = require('helmet');
const compression = require('compression');
const bodyParser = require('body-parser');
const { logger } = require('./helpers/logger');
```