#!/bin/bash -x
printf "Flipping a coin to display heads or tails\n"
#CONSTANTS
HEADS=1
TAILS=0
#VARIABLES

flipACoin=$((RANDOM%2))
if(($flipACoin==$HEADS))
then
	printf "Heads\n"
else
	printf "Tails\n"
fi
