#!/bin/bash

mysql_user="<ADMIN_USER>";
mysql_pass="<PASSWORD>";
source /root/admin-keystone;
nova list;

echo "please input uuid of vm you wish to delete:"
read vm_id;

mysql -u$mysql_user -p$mysql_pass -e "update nova.instances SET vm_state='deleted',task_state=NULL,deleted=1,deleted_at=now() WHERE uuid='$vm_id';"
