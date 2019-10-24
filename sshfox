#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2018_Jun ##
##########################################

################## Usage #################
##    run script from your Terminal     ##
##   via server1 or server2 argument    ##
##########################################
case "$1" in
      server1)
          ssh USER@IP $2 
	        ;;
      server2)
	  ssh USER@IP $2
	  ;;
		
      server3)
	  ssh USER@IP $2
	  ;;
      *)
          echo $"Usage: $0 { server1 | server2 | server3 }"
esac
