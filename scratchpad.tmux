#!/usr/bin/env bash
declare -r CURRENT_DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
declare -r HELPERS_DIR="${CURRENT_DIR}/scripts"

source $HELPERS_DIR/helpers.sh

function main() {
}
main

