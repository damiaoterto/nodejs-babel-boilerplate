FROM node:16-alpine3.15 as development

ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json .

RUN npm install rimraf

RUN npm install --silent

COPY . .

RUN npm run build

FROM node:16-alpine3.15

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json .

RUN npm install --omit=dev --silent

COPY . .

COPY --from=development /usr/src/app/dist ./dist

EXPOSE 3000

CMD ["npm", "start"]
