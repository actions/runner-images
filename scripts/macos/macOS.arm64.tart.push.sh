#!/bin/bash

source scripts/utils.sh

while getopts ":e:v:" opt; do
  case $opt in
    e) warp_env="$OPTARG"
    ;;
    v) mac_image_name="m$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done


if [ "$warp_env" != "warpbuild-1" ] && [ "$warp_env" != "warpbuild-prod" ]; then
  echo "Invalid environment: $warp_env"
  exit 1
fi

if [ "$mac_image_name" != "m14" ] && [ "$mac_image_name" != "m13" ]; then
  echo "Invalid image name: $mac_image_name"
  exit 1
fi

cd images/macos

# Check Preprod env vars
check_env "PREPROD_IMAGE_HOST"
check_env "PREPROD_AWS_ACCESS_KEY_ID"
check_env "PREPROD_AWS_SECRET_ACCESS_KEY"
check_env "PREPROD_AWS_REGION"
check_env "PREPROD_IMAGE_URI"

echo "Logging into ECR for preprod with host $PREPROD_IMAGE_HOST"
login_pass=$(AWS_ACCESS_KEY_ID=${PREPROD_AWS_ACCESS_KEY_ID} \
  AWS_SECRET_ACCESS_KEY=${PREPROD_AWS_SECRET_ACCESS_KEY} \
  AWS_REGION=${PREPROD_AWS_REGION} \
  aws ecr get-login-password)

echo $login_pass | \
  tart login --username AWS --password-stdin $PREPROD_IMAGE_HOST

# Remove ecr-login credHelpers from docker config
echo "Removing config from .docker/config.json"
jq 'del(.credHelpers."'$PREPROD_IMAGE_HOST'")' ~/.docker/config.json > ~/.docker/config.json.new
mv ~/.docker/config.json ~/.docker/config.json.bak
mv ~/.docker/config.json.new ~/.docker/config.json

echo "Pushing image to preprod to $PREPROD_IMAGE_URI"
tart push $mac_image_name $PREPROD_IMAGE_URI
echo "Pushed image to preprod"

# Add ecr-login credHelpers back to docker config
echo "Adding config back to .docker/config.json"
rm ~/.docker/config.json
mv ~/.docker/config.json.bak ~/.docker/config.json

# Check if warp_env is not warpbuild-prod
if [ "$warp_env" != "warpbuild-prod" ]; then
  echo "Warp env is not prod, skipping prod push"
  exit 0
fi

# Check Prod env vars
check_env "PROD_IMAGE_HOST"
check_env "PROD_AWS_ACCESS_KEY_ID"
check_env "PROD_AWS_SECRET_ACCESS_KEY"
check_env "PROD_AWS_REGION"
check_env "PROD_IMAGE_URI"

echo "Logging into ECR for prod with host $PROD_IMAGE_HOST"
login_pass=$(AWS_ACCESS_KEY_ID=${PROD_AWS_ACCESS_KEY_ID} \
  AWS_SECRET_ACCESS_KEY=${PROD_AWS_SECRET_ACCESS_KEY} \
  AWS_REGION=${PROD_AWS_REGION} \
  aws ecr get-login-password)

echo $login_pass | \
  tart login --username AWS --password-stdin $PROD_IMAGE_HOST

# Remove ecr-login credHelpers from docker config
echo "Removing config from .docker/config.json"
jq 'del(.credHelpers."'$PROD_IMAGE_HOST'")' ~/.docker/config.json > ~/.docker/config.json.new
mv ~/.docker/config.json ~/.docker/config.json.bak
mv ~/.docker/config.json.new ~/.docker/config.json

echo "Pushing image to prod to $PROD_IMAGE_URI"
tart push $mac_image_name $PROD_IMAGE_URI
echo "Pushed image to prod"

# Add ecr-login credHelpers back to docker config
echo "Adding config back to .docker/config.json"
rm ~/.docker/config.json
mv ~/.docker/config.json.bak ~/.docker/config.json
