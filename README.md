# chaos-monkey
Chaos monkey for Totem. This chaos monkey has been specially designed for use with Totem deployment in EC2. It supports:
- Reboot of random totem instance

## Scheduling
Monkey can be deployed as a scheduled unit. See http://totem.github.io/config-guide.html#schedule . 
Typically , it should be run every other week. If not deployed using totem, it can be scheduled using any other scheduler like systemd-scheduler , crontab etc.

## Building
```
docker build --rm -t totem/chaos-monkey . 
```

## Running
```
docker run --rm -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} -e TAG_NAME=<ec2-tag-name> -e REGION=<ec2-region> -e DRY_RUN="" totem/chaos-monkey
```

## Build Tags
This repository is build using automated builder for docker hub.  You can see all available tags at:
https://hub.docker.com/r/totem/chaos-monkey/tags


