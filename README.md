# Kong GraphQL Server

Kong GraphQL server is the server that gives more power to your Open API specification and lets you to spin up your own GraphQL server using only your Swagger file.

```
Usage: kongql <command> --<option>

  Commands:
    start       start GraphQL server
    stop        stop running GrapghQL server
    status      show status of the server

  Options:
    --swagger   URL or PATH of swagger file
```

# Installation

## Prerequisites

- [Node.js](https://nodejs.org)

## Installing Packages

Go to the project directory and install Node.js packages with command:

```
npm install
```

## Example Commands

```
## Checking server status
kongql status

# Example response
server is not running

## Starting GraphQL server
kongql start --swagger https://petstore.swagger.io/v2/swagger.json

# Example response
starting the server...
server is running

## Stoping GraphQL server
kongql stop

# Example response
stopping the server...
server is stopped
```

# Running on Docker

```
# Build Docker image from a Docker file
docker build -t kong-graphql-server:0.1 .

# Run container from the image that we build in the previous step
docker run -it -d \
-e GRAPHQL_SWAGGER_URL='https://petstore.swagger.io/v2/swagger.json' \
-e GRAPHQL_PLAYGROUND=true \
-p 3009:3009 \
-t kong-graphql-server:0.1

# Now you can access a GraphQL Playground on http://localhost:3009/graphql
```

## Configuration Parameters

Name | Type | Example
--- | --- | ---
GRAPHQL_SWAGGER_URL | String | https://petstore.swagger.io/v2/swagger.json
GRAPHQL_SERVER_PORT | Number | 3009
GRAPHQL_SERVER_PATH | String | /graphql
GRAPHQL_PLAYGROUND | Boolean | true
