#!/bin/bash

#TOTAL and DAYS are just counters to give a total at the end
TOTAL=0
DAYS=0
#COUNTER is how many days back you want to start
COUNTER=10
#The number here is how many days total you want to go back, keep in mind the head start that COUNTER provides
while [ $COUNTER -lt 355 ]; do
     let COUNTER=COUNTER+1
     MYDATE=`date -v-${COUNTER}d +%c`
     echo "MYDATE = ${MYDATE} -0400" #just displaying some stuff to screen to keep an eye on it
     let DAYS=DAYS+1
     
     COUNTERTWO=0
     #set this number to be number of random possibilities. for example '$RANDOM % 20' will be a number between 1 and 20
     NUMBER=$[ ( $RANDOM % 7 ) + 1 ]
     echo "RANDOM = ${NUMBER}" #just displaying some stuff to screen to keep an eye on it
     while [ $COUNTERTWO -lt $NUMBER ]; do
          let COUNTERTWO=COUNTERTWO+1
          #delete the last line of the file, this to remove the result of the line we are adding
          sed -i '' -e '$ d'  user.php
          #add a line to the end of the file
          echo "${COUNTERTWO} of ${NUMBER} @ ${MYDATE}" >> user.php
          #set the GIT dates so the commit will go back in history
          export GIT_AUTHOR_DATE="${MYDATE} -0400"
          export GIT_COMMITTER_DATE="${MYDATE} -0400"
          #now add and commit the git. I do one big 'git push' manually after this all runs
          ##Probably commented out so as not to accidentally set this off
          #git add --all
          #git commit -m "test update ${COUNTERTWO} of ${NUMBER} @ ${MYDATE}"
          #echo "${COUNTERTWO} of ${NUMBER} @ ${MYDATE}"
          let TOTAL=TOTAL+1
     done
done
#now just display how many days we ran and how many total commits
echo "DAYS = ${DAYS}"
echo "TOTAL = ${TOTAL}"

#a smidge of cleanup
export GIT_AUTHOR_DATE=""
export GIT_COMMITTER_DATE=""
