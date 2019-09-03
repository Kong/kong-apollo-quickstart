#!/usr/bin/env node

const express = require('express');

const app = express();
const { ApolloServer } = require('apollo-server-express');
const graphQLSchema = require('swagger-to-graphql');

// configuration parameters
const pathToSwaggerSchema = process.env.GRAPHQL_SWAGGER_URL;
const serverPort = process.env.GRAPHQL_SERVER_PORT || 3009;
const serverPath = process.env.GRAPHQL_SERVER_PATH || '/graphql';
const playground = process.env.GRAPHQL_PLAYGROUND || false;
const customHeaders = {
 // Authorization: 'Basic YWRkOmJhc2ljQXV0aA==',
};

graphQLSchema(pathToSwaggerSchema, null, customHeaders)
  .then(schema => {
    const apollo = new ApolloServer({ 
      schema,
      playground,
    });
    const app = express();

    apollo.applyMiddleware({ app, path: serverPath });

    app.listen({ port: serverPort }, () => {
      console.log(`🚀 Server ready at http://localhost:${serverPort}${serverPath}`);
    });
  })
  .catch(e => {
    console.log(e);
    process.exit(1);
});
