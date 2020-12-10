## reposerver Base OS role

This role configures following:
- install and configure time sync from NTP
- install VDO and create XFS on top of it
- mount the VDO in /data directory
- install HTTP and RSYNC server with default config
- configure firewall for HTTP/RSYNC server and start both services
- configure public webserver to server files of public mirror

### Notes
It looks that `vdo` module is not idempotent :/, rest should be OK

Example playbook:
~~~
---
- hosts: reposerver
  remote_user: root
  roles:
    - reposerver_base_os
~~~
