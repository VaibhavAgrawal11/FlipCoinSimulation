#!/bin/bash -x
printf "Storing three flips in dictionary and determining percentage of triplet combination\n"

#CONSTANTS
HEADS=1
TAILS=0

#VARIABLES
trippleCount=0
hhhCount=0
hhtCount=0
hthCount=0
thhCount=0
tttCount=0
tthCount=0
thtCount=0
httCount=0
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
headCount=0
tailCount=0
printf "Enter number of times you want to flip the coin: \n"
read iteration
printf "Enter 1:single flip\n2:double flip\n3:tripple flip\n"
read choice

#DICTIONARIES
declare -A singletCount
declare -A doubletCount
declare -A tripletCount
declare -A sortResult

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
case $choice in
	1)
	while(($iteration>0))
	do	
		value=$( flipCoin ) #STORING VALUE OF FIRST COIN
		iteration=$((iteration-1))
		count=$((count+1))
		singletCount["$count"]="$value"
	done
	echo ${singletCount[@]}
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
	sortResult["H"]="$headCount"
	tailPercent=`echo "scale=3; $tailCount/$count*100" | bc -l`
	sortResult["T"]="$tailCount"
	;;

	2)
	while(($iteration>0))
   do 
      arrayCount=0
      value=$( flipCoin ) 
      array1[$arrayCount]=$value #STORING VALUE IN SECOND COIN
      arrayCount=$((arrayCount+1))
      value2=$( flipCoin ) #STORING VALUE OF SECOND COIN
      array1[$arrayCount]=$value2
      iteration=$((iteration-1))
      count=$((count+1))
      doubletCount["$count"]="${array1[@]}"
   done
   echo ${doubletCount[@]}
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
	sortResult["HH"]="$hhCount"
	htPercent=`echo "scale=3; $htCount/$doubleCount*100" | bc -l`
	sortResult["HT"]="$htCount"
	ttPercent=`echo "scale=3; $ttCount/$doubleCount*100" | bc -l`
	sortResult["TT"]="$ttCount"
	thPercent=`echo "scale=3; $thCount/$doubleCount*100" | bc -l`
	sortResult["TH"]="$thCount"
	;;

	3)
   while(($iteration>0))
   do 
      arrayCount=0
      value=$( flipCoin ) 
      array1[$arrayCount]=$value #STORING VALUE IN SECOND COIN
      arrayCount=$((arrayCount+1))
      value2=$( flipCoin ) #STORING VALUE OF SECOND COIN
      array1[$arrayCount]=$value2
		arrayCount=$((arrayCount+1))
		value3=$( flipCoin ) #STORING VALUE OF THIRD COIN
      array1[$arrayCount]=$value3
      iteration=$((iteration-1))
      count=$((count+1))
      tripletCount["$count"]="${array1[@]}"
   done
	echo ${tripletCount[@]}
	for ((value=1; value<=${#tripletCount[@]}; value++))
   do
      if [ "${tripletCount[$value]}" = "H H H" ]; then
         hhhCount=$((hhhCount+1))
      elif [ "${tripletCount[$value]}" = "H H T" ]; then
         hhtCount=$((hhtCount+1))
      elif [ "${tripletCount[$value]}" = "H T H" ]; then
         hthCount=$((hthCount+1))
		elif [ "${tripletCount[$value]}" = "T H H" ]; then
         thhCount=$((thhCount+1))
      elif [ "${tripletCount[$value]}" = "T T H" ]; then
         tthCount=$((tthCount+1))
      elif [ "${tripletCount[$value]}" = "T H T" ]; then
         thtCount=$((thtCount+1))
      elif [ "${tripletCount[$value]}" = "H T T" ]; then
         httCount=$((httCount+1))
      elif [ "${tripletCount[$value]}" = "T T T" ]; then
         tttCount=$((tttCount+1))
      fi
      trippleCount=$((trippleCount+1))
   done
	
   hhhPercent=`echo "scale=3; $hhhCount/$trippleCount*100" | bc -l`
	sortResult["HHH"]="$hhhCount"
	hhtPercent=`echo "scale=3; $hhtCount/$trippleCount*100" | bc -l`
	sortResult["HHT"]="$hhtCount"
	hthPercent=`echo "scale=3; $hthCount/$trippleCount*100" | bc -l`
	sortResult["HTH"]="$hthCount"
	thhPercent=`echo "scale=3; $thhCount/$trippleCount*100" | bc -l`
	sortResult["THH"]="$thhCount"
	tttPercent=`echo "scale=3; $tttCount/$trippleCount*100" | bc -l`
	sortResult["TTT"]="$tttCount"
	tthPercent=`echo "scale=3; $tthCount/$trippleCount*100" | bc -l`
	sortResult["TTH"]="$tthCount"
	thtPercent=`echo "scale=3; $thtCount/$trippleCount*100" | bc -l`
	sortResult["THT"]="$thtCount"
	httPercent=`echo "scale=3; $httCount/$trippleCount*100" | bc -l`
	sortResult["HTT"]="$httCount"
	;;
	*)
	printf "Invalid input..\n"
esac
for value in ${!sortResult[@]}
do
	echo "$value : ${sortResult[$value]}"
done |
sort -rn -k3
