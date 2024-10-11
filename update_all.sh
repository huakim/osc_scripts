#!/bin/bash

if [[ -n "${NOUPDATE}" ]]
then
updatejob(){ :; }
else
updatejob(){ echo fine ; }
fi

job(){
for i in "${@}"
do
 if [[ -d "$i" ]]
 then
  (
  cd "$i"
  updatejob
  osc service mr
  osc add *
  osc ci -m update
  osc service rr
  osc rebuild
  )
 fi
done
}

if (( "${#}" ))
then
  job "${@}"
else
  job *
fi
