#!/usr/bin/env sh

_covid_nhead=25

if [ $# -ne 0 ] && [ $1 -gt 0 ]
then
        _covid_nhead=$1
fi

curl -s https://coronavirus-19-api.herokuapp.com/countries | \
  jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv'  | \
          cut -d, -f4,7 | \
                  sort -t, -k 2nr | \
                          head -n $_covid_nhead | nl
