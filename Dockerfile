FROM node:12.8.0-alpine

WORKDIR /usr/src/app

RUN apk add git openssh-client
COPY . .
RUN npm install

CMD [ "node", "kongql-server.js" ]

