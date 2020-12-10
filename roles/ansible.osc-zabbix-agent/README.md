## zabbix-agent 5.0 deployment role

This role deploys or updates zabbix agent on CentOS 7 machine for use with OSC internal zabbix server.

Role handles:
- installation of zabbix repository and package
- service enable+start
- firewalld configuration
- restart of service in case that config file for zabbix-agent was changed

Example playbook:
~~~
---
- hosts: servers
  remote_user: root
  roles:
    - ansible.osc-zabbix-agent
~~~

### parameters
**server_acl** (default `192.168.0.0/16`):
  defines host/network from which the zabbix agent will accept connection
  multiple options can be separated by comma ','
  
~~~
---
- hosts: servers
  remote_user: root
  roles:
    - { role: 'ansible.osc-zabbix-agent', server_acl: '192.168.0.0/16,10.123.0.0/16' }
~~~
