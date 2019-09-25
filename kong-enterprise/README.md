# Kong Apollo Server

In an effort to bootstrap the value of the Apollo GraphQL Server and the Kong API Gateway - we've developed the kong-apollo-quickstart project. It leverages the querying power of GraphQL and the protection of a gateway, in a Docker container pre-configured to get you up and running quickly.

Kong Apollo server is a server that gives more power to your Open API specification and lets you to spin up your own Apollo GraphQL server using a Swagger file or your Graphql code.


# Running the Docker image

```
# Build Docker image from a Docker file
docker build -t kong-apollo-server:0.1 .

# Run container from the image that we build in the previous step
docker run -it -d \
-e GRAPHQL_SWAGGER_URL='https://petstore.swagger.io/v2/swagger.json' \
-e GRAPHQL_PLAYGROUND=true \
-p 3009:3009 \
-t kong-apollo-server:0.1

# Now you can access a GraphQL Playground on http://localhost:3009/graphql
```

## Configuration Parameters

Name | Type | Example
--- | --- | ---
GRAPHQL_SWAGGER_URL | String | https://petstore.swagger.io/v2/swagger.json
GRAPHQL_SERVER_PORT | Number | 3009
GRAPHQL_SERVER_PATH | String | /graphql
GRAPHQL_PLAYGROUND | Boolean | true
