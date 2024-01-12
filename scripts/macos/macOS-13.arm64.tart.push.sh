#!/bin/bash
set -e


cd images/macos

# check if PREPROD_IMAGE_HOST is set
if [ -z "${PREPROD_IMAGE_HOST}" ]; then
  echo "PREPROD_IMAGE_HOST is not set"
  exit 1
fi
# check if PREPROD_AWS_ACCESS_KEY_ID is set
if [ -z "${PREPROD_AWS_ACCESS_KEY_ID}" ]; then
  echo "PREPROD_AWS_ACCESS_KEY_ID is not set"
  exit 1
fi
# check if PREPROD_AWS_SECRET_ACCESS_KEY is set
if [ -z "${PREPROD_AWS_SECRET_ACCESS_KEY}" ]; then
  echo "PREPROD_AWS_SECRET_ACCESS_KEY is not set"
  exit 1
fi
# check if PREPROD_AWS_REGION is set
if [ -z "${PREPROD_AWS_REGION}" ]; then
  echo "PREPROD_AWS_REGION is not set"
  exit 1
fi
# check if PREPROD_IMAGE_URI is set
if [ -z "${PREPROD_IMAGE_URI}" ]; then
  echo "PREPROD_IMAGE_URI is not set"
  exit 1
fi
# check if PROD_IMAGE_HOST is set
if [ -z "${PROD_IMAGE_HOST}" ]; then
  echo "PROD_IMAGE_HOST is not set"
  exit 1
fi
# check if PROD_AWS_ACCESS_KEY_ID is set
if [ -z "${PROD_AWS_ACCESS_KEY_ID}" ]; then
  echo "PROD_AWS_ACCESS_KEY_ID is not set"
  exit 1
fi
# check if PROD_AWS_SECRET_ACCESS_KEY is set
if [ -z "${PROD_AWS_SECRET_ACCESS_KEY}" ]; then
  echo "PROD_AWS_SECRET_ACCESS_KEY is not set"
  exit 1
fi
# check if PROD_AWS_REGION is set
if [ -z "${PROD_AWS_REGION}" ]; then
  echo "PROD_AWS_REGION is not set"
  exit 1
fi
# check if PROD_IMAGE_URI is set
if [ -z "${PROD_IMAGE_URI}" ]; then
  echo "PROD_IMAGE_URI is not set"
  exit 1
fi

echo "Logging into ECR for preprod with host $PREPROD_IMAGE_HOST"
login_pass=$(AWS_ACCESS_KEY_ID=${PREPROD_AWS_ACCESS_KEY_ID} \
  AWS_SECRET_ACCESS_KEY=${PREPROD_AWS_SECRET_ACCESS_KEY} \
  AWS_REGION=${PREPROD_AWS_REGION} \
  aws ecr get-login-password)

echo $login_pass | \
  tart login --username AWS --password-stdin $PREPROD_IMAGE_HOST

echo "Pushing image to preprod to $PREPROD_IMAGE_URI"
tart push s2 $PREPROD_IMAGE_URI
echo "Pushed image to preprod"

echo "Logging into ECR for prod with host $PROD_IMAGE_HOST"
login_pass=$(AWS_ACCESS_KEY_ID=${PROD_AWS_ACCESS_KEY_ID} \
  AWS_SECRET_ACCESS_KEY=${PROD_AWS_SECRET_ACCESS_KEY} \
  AWS_REGION=${PROD_AWS_REGION} \
  aws ecr get-login-password)

echo $login_pass | \
  tart login --username AWS --password-stdin $PROD_IMAGE_HOST

echo "Pushing image to prod to $PROD_IMAGE_URI"
tart push s2 $PROD_IMAGE_URI
echo "Pushed image to prod"
