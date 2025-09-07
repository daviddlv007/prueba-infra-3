#!/bin/bash
set -e

ENV=${1:-dev}
ACTION=${2:-plan}
TF_DIR="environments/${ENV}"

if [ ! -d "${TF_DIR}" ]; then
  echo "Environment ${ENV} does not exist"
  exit 1
fi

cd "${TF_DIR}"

terraform init -reconfigure
terraform "${ACTION}"