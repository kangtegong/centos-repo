#!/bin/bash
base='/data/centos'
html_file='/var/www/www-public/project-centos.html'
tmp_file=$(mktemp)
out_file=$(mktemp)
echo "<!-- generated at $(date) -->" >> "$tmp_file"
ISOS=$(find $base -name "*.iso"|grep -v '/boot.iso'|grep -v '\-boot.iso'|sed "s:$base::g;")
for iso in $ISOS; do
  version=$(echo "$iso"|cut -d/ -f 2)
  arch=$(echo "$iso"|cut -d/ -f 4)
  basename=$(basename "$iso")
  echo "<tr><td>$version</td><td>$arch</td><td><a href='/centos$iso'>$basename</a></td></tr>" >> "$tmp_file"
done
awk "BEGIN {p=1}
  /^<!-- iso_table_begin -->$/ {print;system(\"cat $tmp_file\");p=0}
  /^<!-- iso_table_end -->$/ {p=1}
p" "$html_file" > "$out_file"
flock -n -E 2 /data/centos -c "cat $out_file > $html_file"
if [ "$?" -eq '2' ]; then
  echo "$(date) ($0): cannot get lock, skipping this script"
  exit 2
fi
rm -f "$tmp_file" "$out_file"
