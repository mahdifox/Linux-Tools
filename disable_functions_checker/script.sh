#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2020_Aug ##
##        check optimize autorepair     ##
##              in mysql                ##
##########################################

################# Usage ##################
##        run script without args       ##
##       to see all valid arguments     ##
##                                      ##
##       to run one arguments needed    ##
##########################################

# Define path of script for future usage
MY_PATH="`dirname \"$0\"`"                        # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

# Define style and color for printing and logs
BOLD=$(tput bold);
NORMAL=$(tput sgr0);
GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m'

# get all php.ini path according to directadmin
/usr/local/directadmin/custombuild/build used_configs  2>/dev/null | grep "php.ini" | awk '{print $5}' > "$MY_PATH/all_iniPath";

while read line
do
	correct_disable_functions="disable_functions = exec,system,passthru,shell_exec,proc_close,proc_open,dl,popen,show_source,posix_kill,posix_mkfifo,posix_getpwuid,posix_setpgid,posix_setsid,posix_setuid,posix_setgid,posix_seteuid,posix_setegid,posix_uname";
	sed -e  "s/.*disable_functions = .*/$correct_disable_functions/" -i  $line
done < $MY_PATH/all_iniPath
