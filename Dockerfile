FROM kong:latest

RUN apk add --update nodejs npm bash openssh git

WORKDIR /kongql

ADD package.json package.json
RUN npm install

ADD bin bin

ENV OAS_URI="https://swapi-with-ids.eskerda.now.sh/oas.yml"
ENV GRAPHQL_SERVER_PORT="3009"

EXPOSE ${GRAPHQL_SERVER_PORT}

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
