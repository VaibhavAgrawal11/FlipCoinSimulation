#!/bin/bash -x
printf "Storing flips in dictionary and determining percentage of singlet combination\n"
#CONSTANTS
HEADS=1
TAILS=0
#VARIABLES
count=0
value=""
headPercent=0
tailPercent=0
printf "Enter number of times you want to flip the coin: \n"
read iteration
headCount=0
tailCount=0
#DICTIONARIES
declare -A singletCount

#FLIP THE COIN TILL THE ITERATION IS EQUAL TO ZERO
while(($iteration>0))
do	
	flipACoin=$((RANDOM%2))
	if(($flipACoin==$HEADS))
	then
		value="Heads"
	else
		value="Tails"
	fi
	iteration=$((iteration-1))
	count=$((count+1))
	singletCount["$count"]="$value"
done
echo ${singletCount[@]}

#COUNTING HEADS AND TAILS
for value in ${singletCount[@]}
do
	if [ "$value" = "Heads" ]; then
		headCount=$((headCount+1))
	else
		tailCount=$((tailCount+1))
	fi
done
headPercent=`echo "scale=3; $headCount/$count*100" | bc -l`
tailPercent=`echo "scale=3; $tailCount/$count*100" | bc -l`

