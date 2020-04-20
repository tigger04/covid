#!/usr/bin/env sh

# default display 25 results
_covid_nhead=25

# unless arg specifying a different number
if [ $# -ne 0 ] && [ $1 -gt 0 ]
then
        _covid_nhead=$1
fi


# curl: retrieve JSON from API
# jq: convert JSON to csv
# cut: only display country (col 4) and deaths per million (col 7)
# sort: by deaths per million (2nd col), in reverse
# head: only display top n lines
# nl: line numbering (rank)

curl -s https://coronavirus-19-api.herokuapp.com/countries | \
  jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv'  | \
  cut -d, -f4,7 | \
  sort -t, -k 2nr | \
  head -n $_covid_nhead | \
  nl
