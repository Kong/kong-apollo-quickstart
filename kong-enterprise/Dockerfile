FROM kong-docker-kong-enterprise-edition-internal-preview-docker.bintray.io/kong-enterprise-edition:1.3-alpine

RUN apk add --update nodejs npm bash openssh git

WORKDIR /kongql

ADD package.json package.json
RUN npm install

ADD bin bin

ENV OAS_URI="https://swapi-with-ids.eskerda.now.sh/oas.yml"
ENV GRAPHQL_SERVER_PORT="3009"

EXPOSE ${GRAPHQL_SERVER_PORT}


# Some KONG settings
ENV KONG_DATABASE="postgres"
ENV KONG_PG_HOST="kong-database"
ENV KONG_PROXY_ACCESS_LOG="/dev/stdout"
ENV KONG_ADMIN_ACCESS_LOG="/dev/stdout"
ENV KONG_PROXY_ERROR_LOG="/dev/stderr"
ENV KONG_ADMIN_ERROR_LOG="/dev/stderr"
ENV KONG_ADMIN_LISTEN="0.0.0.0:8001, 0.0.0.0:8444 ssl"


CMD ["/kongql/bin/kongql", "start", "--docker"]
