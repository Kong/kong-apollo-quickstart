FROM kong:latest

RUN apk add --update nodejs npm bash

WORKDIR /kongql

ADD package.json package.json
ADD src src
RUN npm install

ADD bin bin

# Can either be an url or a local file, ie:
# ADD swagger.json swagger.json
# ENV GRAPHQL_SWAGGER_URL="/usr/local/src/swagger.json"
ENV GRAPHQL_SWAGGER_URL="https://petstore.swagger.io/v2/swagger.json"
ENV GRAPHQL_SERVER_PORT="3009"
ENV GRAPHQL_PLAYGROUND="true"

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
