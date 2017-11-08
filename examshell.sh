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

current_level_folder="src/level_$level"
nb_subject=`ls $current_level_folder | wc -w | bc`
random_subject=`echo $((RANDOM % ${nb_subject} + 1)) | bc`
let "i = 1"
for each_subject in $current_level_folder/*
do
	if [ $i -eq $random_subject ]
	then
		break
	fi
	let "i += 1"
done

echo $each_subject
