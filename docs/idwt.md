# idwt (I Don't Want To)

Use this tool for when you want to block a flatpak from accessing internet, add hosts to /etc/hosts, or completely blocking users from accessing internet (on a schedule, or just ongoing until disabled). All of this just from one config file at `/etc/idwt/config.yml`

## Example

```yml
block:
  flatpak-networking:
    - com.discordapp.Discord
  hosts:
    - facebook.com
user-networking:
  users:
    noah:
      mode: schedule # (allow, block, schedule)
      schedule: schedule1
    john:
      mode: allow # (allow, block, schedule)
  schedules:
    schedule1: # from 8:30 to 15:00 on wednesdays, networking is allowed
      days_allowed: wednesday
      time_start: 8:30
      time_end: 15:00
```