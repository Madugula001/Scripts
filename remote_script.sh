#!/bin/bash
#!/usr/bin/expect

read -p "User name : " username
read -p "Enter Password : " password
read -p "Enter  machinename : " machinename
sshpass -p "$password" ssh $username@$machinename "bash -s" <<EOF


spawn sudo -u worun -i
expect "password"
send "$password" 
echo "Hello Teja" > output.txt
EOF 


<<EOF
app=$1
input_file=$2
#file=$app
file_pass="$(hostname)_${app}_Pass_$(date +%F_%R).txt"
file_fail="$(hostname)_${app}_Fail_$(date +%F_%R).txt"
echo "$app" | tee -a ${file_pass} ${file_fail} > /dev/null
function nc_file()
{
sed -n "/$app/ {s///; :a;n; p; ba; }" $input_file | while read line
do
	if [[ $line = \#* ]]
	then
		echo "$line" | tee -a  "${file_pass}" "${file_fail}" > /dev/null
 		continue
	fi
	if [ -z "$line" ]
	then 
		echo -e "\nDefault List" | tee -a "${file_pass}" "${file_fail}" > /dev/null
		break
	fi

        ncoutput=$( /bin/nc -zv -w 1 $line  2>&1 )
	if echo $ncoutput | grep -q "succeeded"
     	then
#           echo "$line" >> "${file}_PASS_$(date +%F_%R).txt"
	    echo "$line" >> "${file_pass}"
      	else
	    echo "$line" >> "${file_fail}"
#           echo "$line" >> "${file}_FAIL_$(date +%F_%R).txt"
  	 fi

done
}





EOF
#sshpass -p "$docker" scp $docker@$machinename:/home/$docker/output.txt .  
#sshpass -p "$password" rsync --remove-source-files -av $username@$machinename:/home/worun/$(hostname)\* .


#sshpass -p "$password" rsync --remove-source-files -av $username@$machinename:/home/$username/$(hostname)* .



<<EOF
app=$1
input_file=$2
#file=$app
file_pass="${app}_Pass_$(date +%F_%R).txt"
file_fail="${app}_Fail_$(date +%F_%R).txt"
echo "$app" | tee -a ${file_pass} ${file_fail} > /dev/null
function nc_file()
{
sed -n "/$app/ {s///; :a;n; p; ba; }" $input_file | while read line
do
	if [[ $line = \#* ]]
	then
		echo "$line" | tee -a  "${file_pass}" "${file_fail}" > /dev/null
 		continue
	fi
	if [ -z "$line" ]
	then 
		echo -e "\nDefault List" | tee -a "${file_pass}" "${file_fail}" > /dev/null
		break
	fi

        ncoutput=$( /bin/nc -zv -w 1 $line  2>&1 )
	if echo $ncoutput | grep -q "succeeded"
     	then
#           echo "$line" >> "${file}_PASS_$(date +%F_%R).txt"
	    echo "$line" >> "${file_pass}"
      	else
	    echo "$line" >> "${file_fail}"
#           echo "$line" >> "${file}_FAIL_$(date +%F_%R).txt"
  	 fi

done
}
EOF
