#!/bin/bash

set -e

BOLD=$(tput bold)
NC=$(tput sgr0)

for_each() {
  message="${1}"
  shift

  for dir in $(find . -type d -depth 1); do
    if [[ -e $dir/.git ]]; then
      echo "$message $dir"
      ( cd $dir
        $@ )
    fi
  done
}

title() {
  printf "== ${BOLD}$@${NC} ===\n"
}

title "Fetching updates"
git submodule update --remote

# for_each "Updating" git fetch

# title "Matching remote master branch"
# for_each "Resetting" git reset --hard origin/master

title "Updating super-repository"

to_update=$(git status --untracked-files=no --porcelain | awk '{ print $2; }')
update_count=$(echo "$to_update" | wc -l)

# Do we have any updates?
if [[ -n "$to_update" ]]; then
  if [[ $update_count -eq 1 ]]; then
    message="Update $to_update from master"
  elif [[ $update_count -eq 2 ]]; then
    first=$(sed -n 1p <<< "$to_update")
    second=$(sed -n 2p <<< "$to_update")
    message="Update $first, $second from master"
  else
    message="Update $update_count submodules from master"
  fi

  echo "${BOLD}Update message:${NC}"
  echo $message
else
  printf "\nNothing to do.\n"
fi