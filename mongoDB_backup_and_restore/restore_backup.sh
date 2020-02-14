#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2020_Feb ##
##########################################
#
################## Usage #################
##    run script from your Terminal     ##
##   via normal or drop as first arg    ##
##   & Path_of_specific_backup_folder   ##
##             as second arg            ##
##########################################
#
case "$1" in
      normal)
          mongorestore $2
	  ;;
      drop)
	        mongorestore --drop $2
	  ;;
      *)
          echo $"Usage: $0 { normal path_to_specific_backup_folder | drop path_to_specific_backup_folder }"
esac
