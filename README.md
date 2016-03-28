# chaos-monkey
Chaos monkey for Totem. This chaos monkey has been specially designed for use with Totem deployment in EC2. It supports:
- Reboot of random totem instance

## Scheduling
Monkey can be deployed as a scheduled unit. See http://totem.github.io/config-guide.html#schedule . 
Typically , it should be run every other week. If not deployed using totem, it can be scheduled using any other scheduler like systemd-scheduler , crontab etc.

## Running
TBD

