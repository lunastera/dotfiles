#! /bin/sh

# for handling from devcontainer
cd `dirname $0`
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply -S .
