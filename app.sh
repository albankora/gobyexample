#!/usr/bin/env bash

set -e

function usage() {
  echo ""
  echo "Commands:"
  echo ""
  echo "  go       [COMMAND]  Run a go command"
  echo "  build               Build docker environment"
  echo "  run                 Compile and run go app"
  echo "  test                Run unit tests"
  echo "  vet                 Check and reports suspicious constructs"
  echo "  fmt                 Format the code with go standards"
  echo "  bash                Enter the bash interface"
  echo ""
  exit 0
}

APP_NAME="app"
COMPOSE="docker-compose"

if [ $# -gt 0 ];then

    if [ "$1" == "build" ]; then
        ${COMPOSE} build

    elif [ "$1" == "test" ]; then
        ${COMPOSE} run --rm -w /app/src ${APP_NAME} go test ./... -cover

    elif [ "$1" == "go" ]; then
        ${COMPOSE} run --rm -w /app/src ${APP_NAME} "$@"

    elif [ "$1" == "fmt" ]; then
        ${COMPOSE} run --rm -w /app/src ${APP_NAME} go fmt ./...
    
    elif [ "$1" == "vet" ]; then
        ${COMPOSE} run --rm -w /app/src ${APP_NAME} go vet ./...

    elif [ "$1" == "run" ]; then
        shift 1
        ${COMPOSE} run --rm -w /app/src ${APP_NAME} go run -v ./"$1"/main.go

    elif [ "$1" == "bash" ]; then
        ${COMPOSE} run --rm ${APP_NAME} /bin/bash

    else
        ${COMPOSE} run --rm ${APP_NAME} "$@"
    fi

else
    usage
fi