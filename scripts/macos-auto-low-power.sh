#!/usr/bin/env sh

while [ 0 == 0 ]
do
	batt_pct=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

	if [ $batt_pct -lt 35 ]; then
		pmset -a lowpowermode 1
	fi

	if [ $batt_pct -gt 50 ]; then
		pmset -a lowpowermode 0
	fi

	sleep 300
done
