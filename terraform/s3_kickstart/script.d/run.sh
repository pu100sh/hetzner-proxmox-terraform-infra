#!/usr/bin/env bash

set -e

TF_RUN_AS=${TF_RUN_AS:-shell}
source ./conf.d/env.conf
case ${TF_RUN_AS} in
  docker)
    echo "Running as docker"
    docker run -it --rm \
      -v $(git rev-parse --show-toplevel):/$(basename $(git rev-parse --show-toplevel)) \
      -v ${HOME_SSH}:${HOME_SSH} \
      -v /etc/passwd:/etc/passwd \
      -v ${HOME}/.terraformrc:${HOME}/.terraformrc \
      -v ${HOME}/.terraform.d:${HOME}/.terraform.d \
      -u $(id -u):$(id -g) \
      --env-file <(env | grep ARM_) \
      --workdir="/$(basename $(git rev-parse --show-toplevel))/$(git rev-parse --show-prefix)" \
      hashicorp/terraform:${TF_VERSION} $@
  ;;
  shell)
    echo "Running as local binary"
    terraform_${TF_VERSION//./_} --version
    terraform_${TF_VERSION//./_} $@
  ;;
esac
