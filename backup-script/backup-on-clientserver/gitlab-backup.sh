#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2021_Apr ##
##     on host that must backed up      ##
##########################################

################# Usage ##################
##        run script with script        ##
##          from backup-server          ##
##########################################

now_date=`date +"%Y-%B-%d"`;

mkdir -p /backup

#Gitlab-configs
cd /var/opt/gitlab/backups;
/opt/gitlab/bin/gitlab-rake gitlab:backup:create RAILS_ENV=production 2> /dev/null;
mv *.tar "/backup/gitlab-$now_date.tar";

#Gitlab-secret-key
cd /etc/gitlab
tar -czvf git-aaa.tar.gz ./gitlab.rb  ./gitlab-secrets.json
mv git-aaa.tar.gz /backup/git-secret-$now_date.tar.gz
