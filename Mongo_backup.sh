mongodump --out=/data/backup/`date +"%Y%m%d"`/
sudo rm -rf $(ls -1t | tail -n +8)
