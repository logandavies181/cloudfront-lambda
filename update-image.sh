#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

fnName="$1"

imageDigest=$(aws ecr list-images \
  --repository-name "$fnName" \
  --output json |
  jq -r '.imageIds[] | select(.imageTag == "latest") | .imageDigest')
accountId=$(aws sts get-caller-identity --output json | jq '.Account' -r)
region=$(aws configure get region)

uri="${accountId}.dkr.ecr.${region}.amazonaws.com/${fnName}@${imageDigest}"

aws lambda update-function-code --function-name "$fnName" --image-uri "$uri"
