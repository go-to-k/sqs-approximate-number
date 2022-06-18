#/bin/bash

set -eu

cd $(dirname $0)

MessageRetentionPeriod="60"
# MessageRetentionPeriod="120"
# MessageRetentionPeriod="180"
# MessageRetentionPeriod="240"

CFN_TEMPLATE="./template.yml"
STACK_NAME="sqs-queue-size-per-${MessageRetentionPeriod}-period"

aws cloudformation deploy \
    --stack-name ${STACK_NAME} \
    --template-file ${CFN_TEMPLATE} \
    --no-fail-on-empty-changeset \
    --parameter-overrides \
    StackName=${STACK_NAME} \
    MessageRetentionPeriod=${MessageRetentionPeriod}