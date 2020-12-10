#!/bin/bash
date '+%s' --date "$(openssl s_client -servername mirror.opensourcelab.co.kr -host mirror.opensourcelab.co.kr -port 443 -showcerts </dev/null 2>/dev/null|sed -n '/BEGIN CERTIFICATE/,/END CERT/p' |openssl x509 -text 2>/dev/null|sed -n 's/ *Not After : *//p')"
