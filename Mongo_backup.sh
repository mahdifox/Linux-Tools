mkdir -p /data/backup/
mongodump --out=/data/backup/`date +"%Y%m%d"`/
sudo rm -rf $(ls /data/backup/ -1t | tail -n +8)