echo "Remove link latest.dump"
rm latest.dump

echo "Download latest"
heroku pg:backups:capture
heroku pg:backups:download

echo "Rename latest"
now=`date +"%d-%m-%Y"`
mv latest.dump data/$now.latest.dump

echo "Link latest file"
ln -sf data/$now.latest.dump latest.dump

echo "reset"
./reset.sh
