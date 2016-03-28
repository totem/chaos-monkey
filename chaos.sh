#!/bin/bash -e
REGION="${REGION:-us-west-1}"
TAG_NAME="${TAG_NAME:-totem-totem-develop}"
if [ ! -z $DRY_RUN ] ;then
  DRY_RUN_FLAG="--dry-run"
fi
INSTANCES="$(aws ec2 describe-instances --region=$REGION --filters 'Name=tag:Name,Values='$TAG_NAME | grep 'InstanceId')"
if [ "$INSTANCES" != "" ]; then
  echo "$INSTANCES" | xargs echo -n | awk 'BEGIN { RS = ","; FS = ": ";ORS = " "}{print $2}' | xargs shuf -n 1 -e -z | xargs -0 -I {}  aws ec2 reboot-instances $DRY_RUN_FLAG --region=$REGION --instance-ids="{}"
else
  echo "No instances found matching the criteria..."
  exit 1
fi
