#!/usr/bin/env bash
SWAGGER_TO_GQL="node_modules/swagger-to-graphql/bin/swagger2graphql"
SWAGGER_PATH=""

function parse_args() {
  ACTION=$1
  shift 

  case "$1" in
    --swagger)
        SWAGGER_PATH=$2
      ;;
    *)
      ;;
  esac
  shift
}

function instructions() {
cat << EOF

  Usage: kongql <command> --<option>

  Commands:
    start       start GraphQL server
    stop        stop running GrapghQL server
    status      show status of the server

  Options:
    --swagger   URL or PATH of swagger file

EOF
}

function is_swagger_file_valid() {
  $SWAGGER_TO_GQL --swagger=$SWAGGER_PATH > /dev/null
  exit_code=$?
  return $exit_code
}

function upload_swagger_file() {
  export GRAPHQL_SWAGGER_URL=$SWAGGER_PATH
}

function start_server() {
  if [ $(is_server_running) -eq 0 ]; then
    echo "server is already running"
    exit 0
  fi

  if is_swagger_file_valid == 0; then
    upload_swagger_file
    nohup sh -c "node kongql-server.js" & > logs.log
  else
    echo "error occured cannot start the server..."
    exit 1
  fi
}

function is_server_running() {
  [ $(ps -ef | grep 'node kongql-server.js' | awk '{print $2}' | wc -l) -gt 1 ] && echo 0 || echo 1
}

function stop_server() {
  ps -ef | grep 'node kongql-server.js' | awk '{print $2}' | xargs kill
}

function server_status() {
  if [ $(is_server_running) -eq 0 ]; then
    echo "server is running"
  else
    echo "server is not running"
  fi
}

function main() {
  parse_args $@

  case $ACTION in
    start)
        echo "starting the server..."
        start_server
        echo "server is running"
      ;;
    stop)
        echo "stopping the server..."
        stop_server
        echo "server is stopped"
      ;;
    status)
        server_status
      ;;
    *)
      instructions
      exit 1
      ;;
  esac

}

main $*

