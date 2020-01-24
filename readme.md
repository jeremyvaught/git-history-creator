git-history-creator
===================

A silly little tool to backfill your git history

Quick and dirty gettin's going...

- Create a file where you want the magic to happen
  - example `touch temp_updater.sh`
- Get the contents of the bash script and place them in `temp_updater.sh`
- Make the file executable
  - `chmod +x temp_updater.sh`
- Edit the file, paying attention to 
  - `DAYSOFFSET=10` This is how many days back you want to start from, default is to start from 10 days ago
  - `DAYSTORUN=5` This is how many days will get updated
  - `POSSIBLEUPDATESPERDAY=7` This is most possible per day, but the actual number is randomized from 1 to what this is set to
  - `TIMEZONEOFFSET="-0400"` This is the end of the date. If you are not sure what yours is, type `git log` and you'll see it there
  - Decide which file to update and update it. There are two places, currently it's set to `readme.md`. What happens is the script will add a line to the end of the file, something like `3 of 3 @ Mon May 27 18:44:02 2013` which is the update of how many total updates for that day, and the date. This is the change that gets submitted. That line is removed and replaced with each commit.
  - I also suggest that unless you want `git-history-creator.sh` in your repo, you add it to your `.gitignore` file
  - Finally, towards the end of the file, there are the git commands, currently commented out for your safety and mine. Before you uncomment, check to make sure you are going to get what you want. Do that by typing in the command `./git-history-creator` and you will get a readout of each day it processes and how many commits that push would have received. Of course, it's random, so it won't be that same number when you run it again. Uncomment the `git add --all` and `git commit ...` lines, and you, my friend, are a git history revisionist.
- Do a `git push`
- Oh! And the changes won't show up in github until the following day. So don't freak out. [This may not be true anymore. I just ran it again to test and it showed up right away.] However, It does seem that if you go fo a super long period of time, the newest days start dropping off. Not sure if this is a limitation on the commits per push or what.
- And just to be sure, when you are finished, in your command-line, run `export GIT_AUTHOR_DATE=""` and `export GIT_COMMITTER_DATE=""` just to make sure those are reset back to default

WARNING
-------

This script changes things, and does so automatically. So, you should probably be careful, and know that running it could cause problems on your computer up to and including physical death. So know that I wring my hands of any responsibility and my conscious is clear.

LICENSE
-------
[MIT license](http://mit-license.org) seems like a good idea. If you make changes and improvements, it would be awesome if you let me know so I can possibly use them.
3 of 5 @ Fri Jan 24 04:15:54 2020
