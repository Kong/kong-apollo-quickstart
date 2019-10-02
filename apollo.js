const { gql } = require('apollo-server');

const typeDefs = gql`
type Query {
  hello: Hello
}

type Hello {
  message: String
}
`;

const resolvers = {
    Query: {
        hello: function() {
            return { "message": "hello world" }
        }
    }
}

// Maybe some context for authentication
// context: ({ req }) => {
//    // get the user token from the headers
//    const token = req.headers.authorization || '';
//
//    // try to retrieve a user with the token
//    const user = getUser(token);
//
//    // add the user to the context
//    return { user };
//  },


const engine = {
    // The Graph Manager API key
    apiKey: process.env.APOLLO_API_KEY,
}


module.exports = {
    typeDefs,
    resolvers,
    engine,
    playground: process.env.APOLLO_PLAYGROUND_ENABLED? true: false,
    introspection: process.env.APOLLO_INTROSPECTION_ENABLED? true: false,
    // context,
}
