#!/bin/env bash


OS=$(uname)
ROOT_DIR=$(pwd)


if [ "$OS" == "Linux" ]; then
	source ./scripts/linux_setup.sh
elif [ "$OS" == "Darwin" ]; then
	source ./scripts/macOS_setup.sh
fi
