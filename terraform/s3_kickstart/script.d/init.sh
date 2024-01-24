#!/usr/bin/env bash

TF_RUN_AS=${TF_RUN_AS:-shell}
source ./conf.d/env.conf
if [ ! -f .terraform.lock.hcl ]; then
  RUN_PROVIDERS=true
fi
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
      hashicorp/terraform:${TF_VERSION} init $@ \
      -backend-config="bucket=${S3_BUCKET}" \
      -backend-config="key=${S3_KEY}" \
      -backend-config="dynamodb_table=${DDB_TABLE}"
  ;;
  shell)
    echo "Running as local binary"
    which _terraform_download > /dev/null && _terraform_download ${TF_VERSION//_/.} || echo -e "\033[33;7mWARN: Cannot validate Terraform installation. Please consider updating Toolkit\033[0m"
    terraform_"${TF_VERSION//./_}" --version
    terraform_"${TF_VERSION//./_}" init $@ \
      -backend-config="bucket=${S3_BUCKET}" \
      -backend-config="key=${S3_KEY}" \
      -backend-config="dynamodb_table=${DDB_TABLE}"
    if [ "${RUN_PROVIDERS}" == "true" ]; then
      echo "Dependency lock file missing! Creating"
      terraform_"${TF_VERSION//./_}" providers lock \
        -platform=linux_amd64 \
        -platform=darwin_amd64
    fi
  ;;
esac
