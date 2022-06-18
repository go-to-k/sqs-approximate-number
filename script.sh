#/bin/bash

set -eu

MessageRetentionPeriod="60"
# MessageRetentionPeriod="120"
# MessageRetentionPeriod="180"
# MessageRetentionPeriod="240"

STACK_NAME="sqs-queue-size-per-${MessageRetentionPeriod}-period"

filename="sample.txt"
bucketname="${STACK_NAME}-bucket"

touch ${filename} && echo "aaa" > ${filename}

for i in $(seq 1 5); do
    aws s3 cp ${filename} s3://${bucketname}/
    sleep 360 # 最大値の240の前と後に1分ずつ幅を持たせる（ラグ用）

    aws s3 rm s3://${bucketname}/${filename}
    sleep 360 # 同じ値でsleep
done