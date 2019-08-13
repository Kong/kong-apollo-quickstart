const express = require('express');

const app = express();
const { ApolloServer } = require('apollo-server-express');
const graphQLSchema = require('swagger-to-graphql');

const pathToSwaggerSchema = process.env.GRAPHQL_SWAGGER_URL;
const customHeaders = {
 // Authorization: 'Basic YWRkOmJhc2ljQXV0aA==',
};

graphQLSchema(pathToSwaggerSchema, null, customHeaders)
  .then(schema => {
    const apollo = new ApolloServer({ schema })
    const app = express()
    
    apollo.applyMiddleware({ app })
   
    app.listen({ port: 3009 }, () =>
      console.log(`🚀 Server ready at http://localhost:3009/graphql`)
    ) 
  })
  .catch(e => {
    console.log(e);
    process.exit(1)
});
