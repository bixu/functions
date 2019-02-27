logstream() {
  if [ -z $1 ]; then
    echo ""
    echo "Stream logs from hosts in your Chef environment(s)."
    echo "Usage: logstream <development | staging | production>"
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

toml_key() {
  if [ -z $2 ]; then
    echo ""
    echo "Usage: toml_key <key name> <TOML file>"
    echo ""
  fi
  grep $1 $2 \
    | awk 'BEGIN{FS=" = "}{print $2}' \
    | awk 'BEGIN{FS="\""}{print $2}'
}

function studio () {
  hab studio enter
}
