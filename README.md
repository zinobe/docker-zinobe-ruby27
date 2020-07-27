# Ruby 2.7

Ruby 2.7 with supervisord.

**Base image:** `ruby:2.7.1-slim`

**WORKDIR:** `/www`

Add **aws-env** util form AWS SSM ([aws-env](https://github.com/Droplr/aws-env/))

# Supervisor - Daemon config
```conf
[unix_http_server]
file = /run/supervisord.sock
chmod = 0760
chown = www:www

[supervisord]
pidfile=/run/supervisord.pid
; Log information is already being sent to /dev/stdout by default, which gets captured by Docker logs.
; Storing log information inside the contaner will be redundant, hence using /dev/null here
logfile = /dev/null
logfile_maxbytes = 0

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl = unix:///run/supervisord.sock
```
