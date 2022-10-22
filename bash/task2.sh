#!/bin/bash
logfile="$2"

usage () {
  echo "Order: ./script.sh --key log_file"
  echo "--first key displays from which ip were the most requests"
  echo "--second key displays the most requested page"
  echo "--third key displays the number of requests from each ip"
  echo "--fourth key displays non-existent pages clients are referred to"
  echo "--fifth key displays time site gets the most requests"
  echo "--sixth key displays search bots have accessed the site"
}

# if no arguments are provided, return usage function
if [ $# -eq 0 ]; then
    usage # run usage function
fi

while [ "$1" != "" ]; do
    case $1 in
    --first)
        awk '{print $1}' $logfile | sort | uniq -c | sort -nr | head -n 1
        ;;
    --second)
        awk {'print $7'} $logfile | sort | uniq -c | sort -rn | head -n 1
        ;;
    --third)
        awk {'print $1'} $logfile | sort | uniq -c | sort -rn
        ;;
    --fourth)
        grep "404" $logfile | awk {'print $7'}
        ;;
    --fifth)
        cat $logfile | cut -d [ -f2 | cut -d ] -f1 | awk -F: '{print $2":00"}' | sort -n | uniq -c | sort -rn
        ;;
    --sixth)
        grep -i "BLEXBot\|Ahrefs\|MJ12bot\|SemrushBot\|Baiduspider\|Seznam\|DotBot\|bingbot\|Googlebot" example_log.log | awk {'print $1, $14'} | sort | uniq | sort -rn
        ;;
    -h | --help)
        usage # run usage function
        ;;
    *)
        exit 1
        ;;
    esac
    shift # remove the current value for `$1` and use the next
done
