#!/bin/bash

#TESTMODE is 1 if true, 0 if false (do it live!)
TESTMODE=1
#COUNTER is how many days back you want to start
DAYSOFFSET=0
DAYSTORUN=0
POSSIBLEUPDATESPERDAY=2
TIMEZONEOFFSET="-0400"

#TOTAL and DAYS are just counters to give a total at the end
TOTAL=0
DAYS=0
#The number here is how many days total you want to go back, keep in mind the head start that DAYSOFFSET provides
COUNTER=$DAYSOFFSET
while [ $COUNTER -le $DAYSTORUN ]; do
     let COUNTER=COUNTER+1
     MYDATE=`date -v-${COUNTER}d +%c`
     echo "MYDATE = ${MYDATE} ${TIMEZONEOFFSET}" #just displaying some stuff to screen to keep an eye on it
     let DAYS=DAYS+1
     
     COUNTERTWO=0
     #set this number to be number of random possibilities. for example '$RANDOM % 20' will be a number between 1 and 20
     NUMBER=$[ ( $RANDOM % $POSSIBLEUPDATESPERDAY ) + 1 ]
     echo "RANDOM = ${NUMBER}" #just displaying some stuff to screen to keep an eye on it
     while [ $COUNTERTWO -lt $NUMBER ]; do
          let COUNTERTWO=COUNTERTWO+1
          #delete the last line of the file, this to remove the result of the line we are adding
          sed -i '' -e '$ d'  readme.md
          #add a line to the end of the file
          echo "${COUNTERTWO} of ${NUMBER} @ ${MYDATE}" >> readme.md
          #set the GIT dates so the commit will go back in history
          export GIT_AUTHOR_DATE="${MYDATE} ${TIMEZONEOFFSET}"
          export GIT_COMMITTER_DATE="${MYDATE} ${TIMEZONEOFFSET}"
          #now add and commit the git. I do one big 'git push' manually after this all runs
          ##Probably commented out so as not to accidentally set this off
          if [ $TESTMODE -eq 0 ]
          then
            git add --all
            git commit -m ":cake: ${COUNTERTWO} of ${NUMBER} @ ${MYDATE}"
          fi
          echo "${COUNTERTWO} of ${NUMBER} @ ${MYDATE}"
          let TOTAL=TOTAL+1
     done
done
#now just display how many days we ran and how many total commits
echo "DAYS = ${DAYS}"
echo "TOTAL = ${TOTAL}"

#a smidge of cleanup
export GIT_AUTHOR_DATE=""
export GIT_COMMITTER_DATE=""
