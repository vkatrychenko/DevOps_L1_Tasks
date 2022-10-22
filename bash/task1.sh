usage () {
  echo "--all key displays the IP addresses and symbolic names of all hosts in the current subnet"
  echo "--target key displays a list of open system TCP ports"
}

all () {
  arp -a | awk '{print $1, $2}' | tr -d '()'
}

target () {
  netstat -atn 
}

# if no arguments are provided, return usage function
if [ $# -eq 0 ]; then
    usage # run usage function
fi

while [ "$1" != "" ]; do
    case $1 in
    -a | --all)
        all #run function that displays the IP addresses and symbolic names of all hosts in the current subnet
        ;;
    -t | --target)
        target #run function that displays a list of open system TCP ports
        ;;
    -h | --help)
        usage # run usage function
        ;;
    *)
        usage #run usage function
        ;;
    esac
    shift # remove the current value for `$1` and use the next
done
