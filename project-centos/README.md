## CentOS project mirror
How to create public mirrors for CentOS - https://wiki.centos.org/HowTos/CreatePublicMirrors

Current UP-TO-DATE CentOS (as of 2020/03) (6.10, 7.7, 8.0, 8.1, 8-stream) is around 300GB - http://mirror.centos.org/dir_sizes_centos

This project additionally sync also CentOS 5.11 that is not supported anymore and not part of CentOS main mirror. CentOS 5.11 is selectivelly synced from centos-vault repository and takes around 85 GB.

**IMPORTANT:** Synchronization scripts here are using server '192.168.0.12' as source of data. For production deployment these needs to be changed to upstream servers that are provided in comments of following scripts and web page:
- `roles/reposerver_project-centos/files/scripts/01_sync_script.sh`
- `roles/reposerver_project-centos/files/scripts/02_sync_script_vault.sh`
- `roles/reposerver_base_os/files/www-public/project-centos.html`

#### project-centos
Deployment steps:
- from `/reposerver/project-centos` directory run `deploy_project-centos.yml` playbook.
  ~~~
  # cd /reposerver/project-centos
  # ansible-playbook deploy_project-centos.yml
  ~~~
- sync the project for the first time (IMPORTANT: this will take many hours to complete - ~300GB of data needs to be downloaded/synced on first sync) - testing this on local network this took 5 hours to complete
  ~~~
  # run-parts /etc/cron.reposerver.d/project-centos
  ~~~
  You can interrupt above operation anytime and start it again, the sync will download only missing/changed files.
- Check state of server and services:
  - run the `deploy_project-centos.yml` playbook with `--check` option and check that there are NO 'changed' tasks.
  ~~~
  # cd /reposerver/project-centos
  # ansible-playbook deploy_project-centos.yml --check
  ...
  PLAY RECAP ******************************************************************
  localhost: ok=15 changed=0 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
  ~~~
  - Check that rsync server provides module 'CentOS' and 'centos-vault'
  ~~~
  # rsync 127.0.0.1::CentOS
  ===============================================================
  Welcome on OpenSource Consulting (OSC) public mirror rsync server
  
  Files provided here are without any guarantees, use at your own risk.
  
  If there is any issue with this service please contact us
  using email mirror-support@osci.kr
  ===============================================================
  안녕하세요. 오픈소스컨설팅 public mirror rsync 서버입니다.
  
  TODO
  ===============================================================
  
  
  drwxr-xr-x              6 2020/03/24 18:18:23 .
  ...  
  ~~~
  ~~~
  # rsync 127.0.0.1::centos-vault
  ===============================================================
  Welcome on OpenSource Consulting (OSC) public mirror rsync server
  
  Files provided here are without any guarantees, use at your own risk.
  
  If there is any issue with this service please contact us
  using email mirror-support@osci.kr
  ===============================================================
  안녕하세요. 오픈소스컨설팅 public mirror rsync 서버입니다.
  
  TODO
  ===============================================================
  
  
  drwxr-xr-x             58 2020/03/16 23:26:38 .
  -rw-r--r--          1,504 2007/02/20 02:57:47 RPM-GPG-KEY-CentOS-5
  -rw-r--r--             11 2020/04/01 11:00:02 TIME
  drwxr-xr-x            131 2014/09/27 21:52:40 5.11
  ~~~
  - check that '/centos' and '/centos-vault' can be listed via web
  ~~~
  # curl -H 'Host: mirror.opensourcelab.co.kr' http://127.0.0.1/centos/
  <html>
  <head><title>Index of /centos/</title></head>
  <body>
  <h1>Index of /centos/</h1><hr><pre><a href="../">../</a>
  </pre><hr></body>
  </html>
  ~~~
  ~~~
  # curl -H 'Host: mirror.opensourcelab.co.kr' http://127.0.0.1/centos-vault/
  <html>
  <head><title>Index of /centos-vault/</title></head>
  <body>
  <h1>Index of /centos-vault/</h1><hr><pre><a href="../">../</a>
  <a href="5.11/">5.11/</a>                                              27-Sep-2014 12:52       -
  <a href="RPM-GPG-KEY-CentOS-5">RPM-GPG-KEY-CentOS-5</a>                               19-Feb-2007 17:57    1504
  <a href="TIME">TIME</a>                                               01-Apr-2020 02:00      11
  </pre><hr></body>
  </html>
  ~~~
  - check that 'zabbix-agent' provides monitoring object for repository
  ~~~
  # zabbix_agentd -p|grep mirrortimestamp
  mirrortimestamp.centos                        [t|1585609201]
  mirrortimestamp.centosvault                   [t|1585706461]
  ~~~
  - check that fake mirrorlist.centos.org is being redirected to mirror.opensourcelab.co.kr adresses and has content
  ~~~
  # curl -L -H 'Host: mirrorlist.centos.org' --resolve 'mirrorlist.centos.org:80:127.0.0.1' 'http://127.0.0.1/?release=8&arch=x86_64&repo=BaseOS&infra=stock'
  http://mirror.opensourcelab.co.kr/centos/8/BaseOS/x86_64/os/
  ~~~

  ~~~
  # curl -L -H 'Host: mirrorlist.centos.org' --resolve 'mirrorlist.centos.org:80:127.0.0.1' 'http://127.0.0.1/?release=7&arch=x86_64&repo=os&infra=stock'
  http://mirror.opensourcelab.co.kr/centos/7/os/x86_64/
  ~~~

  ~~~
  # curl -L -H 'Host: mirrorlist.centos.org' --resolve 'mirrorlist.centos.org:80:127.0.0.1' 'http://127.0.0.1/?release=6&arch=x86_64&repo=os&infra=stock'
  http://mirror.opensourcelab.co.kr/centos/6/os/x86_64/
  ~~~

  ~~~
  # curl -L -H 'Host: mirrorlist.centos.org' --resolve 'mirrorlist.centos.org:80:127.0.0.1' 'http://127.0.0.1/?release=5&arch=x86_64&repo=os'
  http://mirror.opensourcelab.co.kr/centos-vault/5.11/os/x86_64/
  ~~~
