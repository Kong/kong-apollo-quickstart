FROM node:12.8.0-alpine

WORKDIR /usr/src/app

COPY package.json .

COPY package-lock.json .

RUN apk add git openssh-client

RUN npm install

COPY . .

EXPOSE 3009

CMD [ "node", "kongql-server.js" ]

