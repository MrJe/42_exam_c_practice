###COLORS
red='\033[31m'
green='\033[32m'
orange='\033[33m'
blue='\033[34m'
purple='\033[35m'
cyan='\033[36m'
lightred='\033[91m'
lightgreen='\033[92m'
yellow='\033[93m'
lightblue='\033[94m'
pink='\033[95m'
lightcyan='\033[96m'
EOC='\033[0m'
bold='\033[01m'
disable='\033[02m'
underline='\033[04m'
reverse='\033[07m'
strikethrough='\033[09m'

###SELECT LEVEL

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

###MAKE MADE-FOLDER

if [ -d "made" ]
then
	printf "${yellow}WARNING!${EOC}\nIt seems that the '${yellow}made${EOC}' folder already exists, ${yellow}this action will overwrite it${EOC}.\n Are you sure?(yes or no)"
	while true
	do
		read response
		if [ "$response" == "yes" ]
		then
			rmdir made
			break
		elif [ "$response" == "no" ]
		then
			echo "${red}CANCELED${EOC}"
			exit
		fi
		printf "please enter yes or no:"
	done
	#	mv made __madecache__
fi

mkdir made

###RANDOMIZER

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
