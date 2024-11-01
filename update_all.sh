#!/bin/bash

job(){
if [[ -z "${NOUPDATE}" ]]
then
for i in "${@}"
do
 if [[ -d "$i" ]]
 then
  (
  cd "$i"
  osc update
  )
 fi
done
fi

for i in "${@}"
do
 if [[ -d "$i" ]]
 then
  (
  cd "$i"
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
