#!/usr/bin/env node

const fs = require('fs')
const path = require('path')

const request = require('request')
const yaml = require('js-yaml')

const { createGraphQlSchema } = require('openapi-to-graphql')
const { ApolloServer } = require('apollo-server')

// this is a good one "https://swapi-with-ids.eskerda.now.sh/oas.yml"
const OAS_URI = process.env.OAS_URI? process.env.OAS_URI : undefined
const LISTEN_PORT = process.env.APOLLO_SERVER_PORT || 3009

const apollo_defines = require('../apollo')


function fetch_uri(uri, resolve, reject) {
  if (fs.existsSync(uri)) {
    parse_oas(fs.readFileSync(uri, "utf8"), resolve, reject)
    return
  }

  request(uri, function(error, response, body) {
    if (error) {
      reject(error)
    } else if (response.statusCode != 200) {
      reject({status: response.statusCode, body: body})
    } else {
      parse_oas(body, resolve, reject)
    }
  })
}

function parse_oas(body, resolve, reject) {
  try {
    resolve(JSON.parse(body))
  } catch (e) {
    try {
      resolve(yaml.safeLoad(body))
    } catch (f) {
      reject("error parsing remote url: ", e, f)
    }
  }
}


function start_server(ctx) {
  const server = new ApolloServer(ctx)
  server.listen(LISTEN_PORT).then(({ url }) => {
    console.log(`🚀 Server ready at ${url}`)
  })
}

if (OAS_URI !== undefined) {
  fetch_uri(OAS_URI, function(oas) {
    createGraphQlSchema(oas).then(function({schema, _}) {
      const apollo_ctx = { schema }
      start_server({...apollo_defines, ...apollo_ctx})
    })
  }, function(error) {
    console.log(error)
  })
} else {
  start_server(apollo_defines)
}

