# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nrubin <nrubin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/09/15 11:33:10 by nrubin            #+#    #+#              #
#    Updated: 2021/09/15 11:33:20 by nrubin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


arc=$(uname -a)
cpup=$(grep -c ^processor /proc/cpuinfo)
cpuv=$(cat /proc/cpuinfo | grep processor | wc -l)
memu=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
disku=$(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)\n", $3,$2,$5}')
cpul=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
lboot=$(who -b | awk '$1 == "system" {print $3 " " $4}')
lvmu=$(if cat /etc/fstab | grep -q "dev/mapper/"; then echo "yes"; else echo "no"; fi)
tcp=$(cat /proc/net/tcp | wc -l | awk '{print $1-1}' | tr '\n' ' ' && echo "ESTABLISHED")
userl=$(w | wc -l | awk '{print$1-2}')
net=$(echo -n "IP " && ip route list | grep default | awk '{print $3}' | tr '\n' ' ' && echo -n "(" && ip link show | grep link/ether | awk '{print $2}' | tr '\n' ')' && printf "\n")
sudo=$(cat /var/log/sudo/sudo_log | wc -l | tr '\n' ' ' && echo "cmd")

wall "	#Architecture: $arc
	#CPU physical: $cpup
	#vCPU: $cpuv
	#Memory Usage: $memu
	#Disk Usage: $disku
	#CPU load: $cpul
	#Last boot: $lboot
	#LVM use: $lvmu
	#Connexions TCP: $tcp
	#User log: $userl
	#Network: $net
	#Sudo: $sudo"
