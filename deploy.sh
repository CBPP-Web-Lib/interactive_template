rsync -av \
  -e "/usr/bin/ssh" \
  ./html/ cbppapps@vps42437.dreamhostps.com:/home/cbppapps/apps.cbpp.org/$PROJECTID/

rsync -av \
  -e "/usr/bin/ssh" \
  ./node/prod/ cbppapps@vps42437.dreamhostps.com:/home/cbppapps/apps.cbpp.org/$PROJECTID/js/
