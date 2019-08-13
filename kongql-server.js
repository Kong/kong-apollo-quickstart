const express = require('express');

const app = express();
const graphqlHTTP = require('express-graphql');
const graphQLSchema = require('swagger-to-graphql');

const pathToSwaggerSchema = process.env.GRAPHQL_SWAGGER_URL;
const customHeaders = {
 // Authorization: 'Basic YWRkOmJhc2ljQXV0aA==',
};

graphQLSchema(pathToSwaggerSchema, null, customHeaders)
  .then(schema => {
    app.use(
      '/graphql',
      graphqlHTTP(() => {
        return {
          schema,
          graphiql: true,
        };
      }),
    );

    app.listen(3009, '0.0.0.0', () => {
      console.info('http://localhost:3009/graphql');
    });
  })
  .catch(e => {
    console.log(e);
    process.exit(1)
});
