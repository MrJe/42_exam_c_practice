clear
while true
do
	read -p "Please select your level:" level
	if [[ "${level}" =~ ^[0-9]+$ ]]
	then
		level=`echo "$level" | bc`
		if [ $level -lt 6 ] && [ $level -ge 0 ]
		then
			break
		fi
	fi
	echo "Level not available, please enter a level between 0 and 5"
done

if [ -d "made" ]
then
	mv made __cache__
fi

mkdir made
