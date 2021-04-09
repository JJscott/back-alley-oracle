# Build stage
# 
FROM node:14.16.1-buster as build-stage

WORKDIR /app

# Copy and build source files
COPY . .
RUN set -x \
    && npm ci --only=production \
    && npm run build



# Production stage
# 
FROM node:14.16.1-buster-slim as prod-stage

ENV NODE_ENV production

# copy built files
USER node
WORKDIR /app
COPY --chown=node:node --from=build-stage /app/dist ./dist
COPY --chown=node:node --from=build-stage /app/package*.json ./
COPY --chown=node:node --from=build-stage /app/node_modules ./node_modules

CMD ["npm", "run", "start"]

# RUN apt-get install dumb-init
# CMD ["dumb-init", "npm", "run", "start"]
