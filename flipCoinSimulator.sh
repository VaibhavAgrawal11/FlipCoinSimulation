#!/bin/bash -x
printf "Storing two flips in dictionary and determining percentage of doublet combination\n"
#CONSTANTS
HEADS=1
TAILS=0
#VARIABLES
doubleCount=0
count=0
value=""
value2=""
headPercent=0
tailPercent=0
hhCount=0
ttCount=0
htCount=0
thCount=0
printf "Enter number of times you want to flip the coin: \n"
read iteration
headCount=0
tailCount=0
#DICTIONARIES
declare -A singletCount

#FUNCTION TO FLIP A COIN
function flipCoin()
{
	flipACoin=$((RANDOM%2))
	if(($flipACoin==$HEADS))
   then
      value="H"
   else
      value="T"
   fi
	echo $value
}
#FLIP THE COIN TILL THE ITERATION IS EQUAL TO ZERO
while(($iteration>0))
do	
	arrayCount=0
	value=$( flipCoin ) #STORING VALUE OF FIRST COIN
	array1[$arrayCount]=$value #STORING VALUE OF FIRDT COIN IN SECOND COIN
	arrayCount=$((arrayCount+1))
	value2=$( flipCoin ) #STORING VALUE OF SECOND COIN
	array1[$arrayCount]=$value2
	iteration=$((iteration-1))
	count=$((count+1))
	singletCount["$count"]="$value"
	doubletCount["$count"]="${array1[@]}"
done
echo ${singletCount[@]}
echo ${doubletCount[@]}

#COUNTING SINGLET HEADS AND TAILS
for value in ${singletCount[@]}
do
	if [ "$value" = "H" ]; then
		headCount=$((headCount+1))
	else
		tailCount=$((tailCount+1))
	fi
done
headPercent=`echo "scale=3; $headCount/$count*100" | bc -l`
tailPercent=`echo "scale=3; $tailCount/$count*100" | bc -l`

#COUNTING DOUBLET HEADS AND TAILS
for ((value=1; value<=${#doubletCount[@]}; value++))
do
	if [ "${doubletCount[$value]}" = "H T" ]; then
		htCount=$((htCount+1))
	elif [ "${doubletCount[$value]}" = "T H" ]; then
      thCount=$((thCount+1))
	elif [ "${doubletCount[$value]}" = "T T" ]; then
      ttCount=$((ttCount+1))
	else 
		hhCount=$((hhCount+1))
	fi
	doubleCount=$((doubleCount+1))
done
hhPercent=`echo "scale=3; $hhCount/$doubleCount*100" | bc -l`
htPercent=`echo "scale=3; $htCount/$doubleCount*100" | bc -l`
ttPercent=`echo "scale=3; $ttCount/$doubleCount*100" | bc -l`
thPercent=`echo "scale=3; $thCount/$doubleCount*100" | bc -l`
