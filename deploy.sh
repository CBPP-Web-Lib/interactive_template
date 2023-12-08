rsync -av \
  -e "/usr/bin/ssh" \
  ./html/ cbppapps@apps.cbpp.org:/home/cbppapps/apps.cbpp.org/$PROJECTID/

rsync -av \
  -e "/usr/bin/ssh" \
  ./node/prod/ cbppapps@apps.cbpp.org:/home/cbppapps/apps.cbpp.org/$PROJECTID/js/
