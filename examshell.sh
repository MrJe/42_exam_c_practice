###PATHS

src_path=".src"
data_path=".data"

###DEPENDENCIES

source $src_path/color.sh

###SELECT LEVEL
ex_sh="${cyan}examshell:${EOC}"

clear
while true
do
	printf "${ex_sh}please select your level:"
	read level
	if [[ "${level}" =~ ^[0-9]+$ ]]
	then
		level=`echo "$level" | bc`
		if [ $level -lt 6 ] && [ $level -ge 0 ]
		then
			break
		fi
	fi
	echo "level not available, please enter a level between 0 and 5"
done

###MAKE MADE-FOLDER

if [ -d "made" ]
then
	printf "${ex_sh}${yellow}WARNING!${EOC}\nIt seems that the '${yellow}made${EOC}' folder already exists, ${yellow}this action will overwrite it${EOC}.\nare you sure?(yes or no)"
	while true
	do
		read response
		if [ "$response" == "yes" ]
		then
			rmdir made
			break
		elif [ "$response" == "no" ]
		then
			echo "${ex_sh}${red}CANCELED${EOC}"
			exit
		fi
		printf "please enter 'yes' or 'no':"
	done
	#	mv made __madecache__
fi

mkdir made

###RANDOMIZER

current_level_folder="$data_path/level_$level"
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

affectation=`echo $each_subject | rev | cut -d/ -f1 | rev`
echo "${ex_sh}the level assigned is ${bold}${affectation}${EOC}"

while true
do
	printf "${ex_sh}"
	read response
	if [ "$response" == "grademe" ]
	then
		break
	elif [ "$response" == "logout" ]
	then
		echo "logout"
		exit
	fi
	echo "options: 'grademe' 'logout'"
done

echo "${ex_sh}your exercise is evaluated..."

if [ -f "$each_subject/main.c" ]
then
	gcc $each_subject/main.c made/* -o $src_path/current
else
	gcc made/* -o $src_path/current
fi

nb_test=`cat $each_subject/test/__instructions__ | wc -l | bc`
let "i=0"
while [ $i -lt $nb_test ]
do
	instr="`awk "NR==$i" $each_subject/test/__instructions__`"
	printf ${instr#./ref}
	./$src_path/current ${instr#./ref }
	./$each_subject/ref ${instr#./ref }
	let "i +=1"
done
