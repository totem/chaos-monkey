#!/bin/bash -e
REGION="${REGION:-us-west-1}"
TAG_NAME="${TAG_NAME:-totem-totem-develop}"
RUN_ON_EVEN_WEEKS="${RUN_ON_EVEN_WEEKS:-true}"
RUN_ON_ODD_WEEKS="${RUN_ON_ODD_WEEKS:-true}"
if [ ! -z $DRY_RUN ] ;then
  DRY_RUN_FLAG="--dry-run"
fi
week=$(date +%U)

if [ "$RUN_ON_EVEN_WEEKS" == "false" ] && [ $(($week % 2)) == 0 ]; then
  echo "chaos-monkey: Not active on even weeks. Set RUN_ON_EVEN_WEEKS to true for creating chaos on even weeks"
  exit 0
fi

if [ "$RUN_ON_ODD_WEEKS" == "false" ] && [ $(($week % 2)) == 1 ]; then
  echo "chaos-monkey: Not active on odd weeks. Set RUN_ON_ODD_WEEKS to true for creating chaos on odd weeks"
  exit 0
fi

INSTANCES="$(aws ec2 describe-instances --region=$REGION --filters 'Name=tag:Name,Values='$TAG_NAME | grep 'InstanceId')"
if [ "$INSTANCES" != "" ]; then
  REBOOT_INSTANCE=$(echo "IGONRE_BUG: IGNORE_BUG,$INSTANCES" | xargs echo -n | awk 'BEGIN { RS = ","; FS = ": ";ORS = " "}{print $2}' | xargs shuf -n 1 -e -z)
  echo "chaos-monkey: Rebooting instance $REBOOT_INSTANCE "
  aws ec2 reboot-instances $DRY_RUN_FLAG --region=$REGION --instance-ids="$REBOOT_INSTANCE"
else
  echo "No instances found matching the criteria..."
  exit 1
fi
