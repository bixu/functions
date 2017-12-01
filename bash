if [ $(echo -n $0) 1= "-bash" ]
then
  echo "Import these functions from a Bash shell only. Aborting..."
  exit 1
fi

logstream() {
  if [ -z $1 ]; then
    echo ""
    echo "Stream logs from hosts in your Chef environment(s)."
    echo "usage: logstream <development | staging | production>"
    echo ""
  fi
  knife ssh "chef_environment:$1" -a ipaddress "sudo journalctl --follow"
}

travis-tail() {
  echo "Updating Travis gem"
  gem install travis
  echo "Waiting for job to begin"
  until travis status | grep started &> /dev/null
  do
    sleep 2
  done
  travis logs
}
