# Kong Apollo Server

In an effort to bootstrap the value of the Apollo GraphQL Server and the Kong API Gateway - we've developed the kong-apollo-quickstart project. It leverages the querying power of GraphQL and the protection of a gateway, in a Docker container pre-configured to get you up and running quickly.

Kong Apollo server is a server that gives more power to your Open API specification and lets you to spin up your own Apollo GraphQL server using a Swagger file or your Graphql code.

# Usage and configuration

This image can neither be started by providing typeDefs and resolvers on
the `apollo.js` file, or by providing an OpenAPI spec file through the `OAS_URI`
environment variable.

Note that everything in `apollo.js` is used to start the Apollo server, be
it an Apollo engine API_KEY, custom resolvers, schema, typeDefs, custom
authorization, etc.


## Running the Docker image

```
# Build Docker image from a Docker file
docker build -t kong-apollo-server:0.1 .

# Run container from the image that we build in the previous step
docker run -it -d \
   -e OAS_URI='https://swapi-with-ids.eskerda.now.sh/oas.yml'
   -p 3009:3009 \
   -t kong-apollo-server:0.1

# Now you can access a GraphQL Playground on http://localhost:3009/graphql
```

`apollo.js` can either be customized and the image rebuilt, or a new
file can be mounted when starting the container as:

```
docker run -it -d \
   -v path/to/an/apollo.js:/kongql/apollo.js \
   -p 3009:3009 \
   -t kong-apollo-=server:0.1
```


## Configuration Parameters

Name | Type | Example
--- | --- | ---
APOLLO_PLAYGROUND_ENABLED | Boolean | true
APOLLO_INTROSPECTION_ENABLED | Booolean | true
APOLLO_SERVER_PORT | Number | 3009
OAS_URI | String | https://swapi-with-ids.eskerda.now.sh/oas.yml
