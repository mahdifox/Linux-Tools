##########################################
## Created_By_Mahdi_Bagheri_at_2021_Apr ##
##     on host that must backed up      ##
##########################################

################# Usage ##################
##        run script with script        ##
##########################################

#specify path you want containers backed up.
path=/backup;
mkdir -p $path;
count=`docker ps -qa | wc -l`;
declare -A containers=()

for ((i=1;i<=$count;i++))
do
        container_id=`docker ps -qa | awk "NR==$i"`;
        container_name=`docker inspect --format={{.Name}} $container_id | cut -d '/' -f2`;
        containers+=([$container_id]=$container_name);
done


for container_id in ${!containers[@]}
do
        docker commit  -p $container_id  ${containers[$container_id]}
        docker save -o $path/$container_id-${containers[$container_id]}.tar ${containers[$container_id]}
        echo "backup of ${containers[$container_id]} container is now available under $path path";
done
