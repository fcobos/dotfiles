#!/usr/bin/env sh

while true
do
	power_source=$(pmset -g batt | head -n 1 | cut -d \' -f2)
	batt_pct=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

	if [ "$batt_pct" -lt 25 ] && [ "$power_source" = "Battery Power" ]; then
		pmset -a lowpowermode 1
	fi

	if [ "$batt_pct" -gt 25 ] && [ "$power_source" = "AC Power" ]; then
		pmset -a lowpowermode 0
	fi

	sleep 300
done
