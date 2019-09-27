FROM kong:latest

RUN apk add --update nodejs npm bash openssh git

WORKDIR /kongql

ADD package.json package.json
RUN npm install

# Any apollo setting goes to this file. Alternatively, you can always
# mount your/apollo/file:/kongql/apollo.js
ADD apollo.js apollo.js

ADD src src
ADD bin bin

# You can define an OpenAPI spec file as OAS_URI, this will autogenerate
# a graphql server around it
# ie: https://swapi-with-ids.eskerda.now.sh/oas.yml
# defaults to unset
# You can also provide it at runtime

ARG OAS_URI=""

ENV APOLLO_INTROSPECTION_ENABLED=1
ENV APOLLO_PLAYGROUND_ENABLED=1
ENV APOLLO_SERVER_PORT=3009
ENV OAS_URI=${OAS_URI}

EXPOSE ${GRAPHQL_SERVER_PORT}
EXPOSE 8000 8001 8443 8444

# Kong declarative config
ADD kong.yml kong.yml

# Some KONG settings
ENV KONG_DATABASE="off"
ENV KONG_PROXY_ACCESS_LOG="/dev/stdout"
ENV KONG_ADMIN_ACCESS_LOG="/dev/stdout"
ENV KONG_PROXY_ERROR_LOG="/dev/stderr"
ENV KONG_ADMIN_ERROR_LOG="/dev/stderr"
ENV KONG_ADMIN_LISTEN="0.0.0.0:8001, 0.0.0.0:8444 ssl"
ENV KONG_DECLARATIVE_CONFIG="/kongql/kong.yml"

CMD ["/kongql/bin/kongql", "start", "--docker"]
