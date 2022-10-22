usage () {
  echo "Order: ./script.sh source_dir destination_path"
  echo "Example: ./script.sh dir1/ dir2"
  echo "Note, without the trailing slash, dir1, including the directory, would be placed within dir2"

}

now=`date '+%F_%H:%M:%S'`

# if no arguments are provided, return usage function
if [ $# -eq 0 ]; then
    usage # run usage function
fi

if [ -n "$1" ] && [ -n "$2" ]; then
    read -n 3 -t 10 -p "Would you like to delete the current files in the destination dir? yes or no (waiting for 10 seconds)" answer
    if [ $answer == yes ]; then
      echo "The existing files in the dest folder are removed" 
      echo "The dir/file are being synced from source $1 to destination $2"
      echo "Log file will be created in the current directory"
      rsync -a $1 $2 --delete --log-file=log-$now.txt
    else
      echo "The dir/file are being synced from source $1 to destination $2"
      echo "Log file will be created in the current directory"
      rsync -a $1 $2 --log-file=log-$now.txt
    fi
fi
