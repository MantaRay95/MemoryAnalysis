#!/bin/sh

if [ "$#" -eq 1 ]
then
	file="$1"
	echo "Checking 'System'......"
	systemcount=$(cat $file | grep -i system | wc -l)
	if [ $systemcount -gt 1 ]
	then
		echo "More than 1 'System' found. This is abnormal."
		echo "$(cat $file | grep -i system.exe)"
	elif [ $systemcount -eq 0 ]
	then
		echo "Instances of 'System' is 0. This is abnormal."
	fi

	echo "Checking 'smss.exe'......"
	smssmastercount=$(cat $file | grep " 4 " | grep -i smss.exe | wc -l)
	if [ $smssmastercount -gt 1 ]
	then
		echo "More than 1 smss master found. This is abnormal."
		echo "$(cat $file | grep " 4 " | grep -i smss.exe)"
	elif [ $smssmastercount -eq 0 ]
	then
		echo "Instance of master smss could not found. This is abnormal."
	fi

	smsscount=$(cat $file | grep -i smss.exe | wc -l)
	if [ $smsscount -gt 2 ]
	then
		echo "Please check 'smss.exe' files manually to verify all childs are instances of master smss"
		echo "Master smss"
		echo "$(cat $file | grep " 4 " | grep -i smss.exe)"
		echo "Child smss"
		echo "$(cat $file | grep -v " 4 " | grep -i smss.exe)"
	fi

	echo "Checking 'services.exe'......"
	servicescount=$(cat $file | grep -i services.exe | wc -l)
	if [ $servicescount -gt 1 ]
	then
		echo "More than 1 'services.exe' found. This is abnormal."
		echo "$(cat $file | grep -i services.exe)"
	elif [ $servicescount -eq 0 ]
	then
		echo "A instance of 'services.exe' could not found. This is abnormal."
	fi

	echo "Checking 'lsass.exe'......"
	lsasscount=$(cat $file | grep -i lsass.exe | wc -l)
	if [ $lsasscount -gt 1 ]
	then
		echo "More than 1 'lsass.exe' found. This is abnormal."
		echo "$(cat $file | grep -i lsass.exe)"
	elif [ $lsasscount -eq 0 ]
	then
		echo "A instance of 'lsass.exe' could not found. This is abnormal."
	fi

	wininitcount=$(cat $file | grep -i wininit.exe | wc -l)
	if [ $wininitcount -eq 1 ]
	then
		wininitpid=$(cat $file | grep -i wininit.exe | tr -s ' ' | cut -d ' ' -f3)
		servicesppid=$(cat $file | grep -i services.exe | tr -s ' ' | cut -d ' ' -f4)
		lsassppid=$(cat $file | grep -i lsass.exe | tr -s ' ' | cut -d ' ' -f4)
		if [ -z "$wininitpid" ]
		then
			echo "Cannot get 'wininit.exe' pid"
			echo "$(cat $file | grep -i wininit.exe)"
			echo "$(cat $file | grep -i services.exe)"
			echo "$(cat $file | grep -i lsass.exe)"
		else
			if [ -z "$servicesppid" ]
			then
				echo "Cannot get 'services.exe' pid."
				echo "$(cat $file | grep -i wininit.exe)"
				echo "$(cat $file | grep -i services.exe)"
			else
				if [ $servicesppid -ne $wininitpid ]
				then
					echo "Parent of 'services.exe' is not 'wininit.exe'. This is abnormal."
					echo "$(cat $file | grep -i wininit.exe)"
					echo "$(cat $file | grep -i services.exe)"
				fi
			fi
			if [ -z "$lsassppid" ]
			then
				echo "Cannot get 'lsass.exe' pid."
				echo "$(cat $file | grep -i wininit.exe)"
				echo "$(cat $file | grep -i lsass.exe)"
			else
				if [ $lsassppid -ne $wininitpid ]
				then
					echo "Parent of 'lsass.exe' is not 'wininit.exe'. This is abnormal."
					echo "$(cat $file | grep -i wininit.exe)"
					echo "$(cat $file | grep -i lsass.exe)"
				fi
			fi
		fi
	elif [ $wininitcount -gt 1 ]
	then
		echo "More than 1 'wininit.exe' found. Abnormal Environment."
		echo "$(cat $file | grep -i wininit.exe)"
	else
		echo "'wininit.exe' could not be found. Abnormal Environment."
		echo "Check parent of services.exe and lsass.exe"
		echo "$(cat $file | grep -i services.exe)"
		echo "$(cat $file | grep -i lsass.exe)"
		
	fi

	echo "Checking 'svchost.exe'......"
	echo "Please check all 'svchost.exe' are children of 'services.exe'"
	echo "$(cat $file | grep -i services.exe)"
	echo "$(cat $file | grep -i svchost.exe)"
	normal=$(cat $file | grep -i svchost.exe | wc -l)
	abnormal=$(cat $file | grep -i -e s..host.exe -e s.host.exe -e s...host.exe | wc -l)
	if [ $normal -ne $abnormal ]
	then
		echo "Some names similar to svchost found"
		echo "$(cat $file | grep -i -e s..host.exe -e s.host.exe -e s...host.exe | grep -v svchost.exe)"
	fi
else
	echo "Usage: ./basicanalysis path_to_pslist.txt"
fi
