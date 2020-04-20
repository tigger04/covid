#!/bin/zsh
curl -s https://coronavirus-19-api.herokuapp.com/countries | \
  jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' | \
  cut -d',' -f4 -f7 | \
  sort -t',' -k 2nr | \
  head -n 40 | nl
