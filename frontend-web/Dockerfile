# build stage
FROM node:15.7.0-alpine3.10 as build-stage

ENV NODE_ENV production

WORKDIR /app

COPY package*.json ./

RUN npm ci --only=production

COPY . .

RUN npm build


# production stage
#FROM node:15.7.0-alpine3.10 as production-stage

EXPOSE 8000

ENTRYPOINT [ "npm run prod" ]
