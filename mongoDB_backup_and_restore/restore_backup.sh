#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2022_Jun ##
##########################################
#
################## Usage #################
##    run script from your Terminal     ##
##   via normal or drop as first arg    ##
##   & Path_of_specific_backup_folder   ##
##             as second arg            ##
##########################################
#

#define color for print or echo
YELLOW='\033[0;93m';
GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m';

username=$(whoami);

MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi


case "$1" in
      normal_all_db)
          mongorestore --host IP --port PORT --username USERNAME --password PASSWORD --authenticationDatabase admin $2
	  ;;
      drop_all_db)
	  mongorestore --drop --host IP --port PORT --username USERNAME --password PASSWORD --authenticationDatabase admin $2
	  ;;
      normal_with_specific_db_name)
	  mongorestore --host IP --port PORT --username USERNAME --password PASSWORD --authenticationDatabase admin --db $2 $3
	  ;;
      drop_with_specific_db_name)
	  mongorestore --drop --host IP --port PORT --username USERNAME --password PASSWORD --authenticationDatabase admin --db $2 $3
	  ;;
      *)
          echo -e $"${YELLOW}Usage:${NC} ${GREEN}root@$username:$MY_PATH# $0 [ARGUMENT-1] [ARGUMENT-2] [ARGUMENT-3] ${NC}"
	  	  
		 echo ""

		 echo -e "${YELLOW} # INFO: this will restore all of your databases including in backup_folder ! not to delete old ones.${NC}"
		 echo -e "${GREEN} $0 normal_all_db [PATH_TO_BACKUP_FOLDER_TO_RESTORE]${NC}"
		 echo ""

		 echo -e "${YELLOW} # INFO: this will restore all of your databases including in backup_folder ${NC} ${RED}!!! delete all old ones before restore.${NC}"
		 echo -e "${GREEN} $0 drop_all_db [PATH_TO_BACKUP_FOLDER_TO_RESTORE]${NC}"
		 echo ""

		 echo -e "${YELLOW} # INFO: this will restore specific database including in backup_folder ! not to delete old one.${NC}"
		 echo -e "${GREEN} $0 normal_with_specific_db_name [DB_NAME] [PATH_TO_DB_BACKUP_FOLDER]${NC}"
		 echo ""

		 echo -e "${YELLOW} # INFO: this will restore specific database including in backup_folder ${NC} ${RED}!!! delete old one before restore.${NC}"
		 echo -e "${GREEN} $0 drop_with_specific_db_name [DB_NAME] [PATH_TO_DB_BACKUP_FOLDER]${NC}"
esac
