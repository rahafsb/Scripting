#!/bin/bash
ini=$#
arr=("$@")
check=1
integer=1
floatt=1
if (( ini < 2 ))  
then
 check=0
 >&2 echo "Number of parameters received : $ini"  
 >&1 echo "Usage : calculatePayment.sh <valid_file_name> [More_Files] ... <money>"
else 
 i=1
 j=$#
 j=$(( $j-1 ))
 reo='^[0-9]+$'                     
 if ! [[ ${arr[$j]} =~ $reo ]] ; then
  integer=0
 fi 
 reto='^[0-9]+([.][0-9]+)?$'  
 if ! [[ ${arr[$j]} =~ $reto ]] ; then
 floatt=0
 fi 
 if (( $(($integer + $floatt)) == 0 ))
 then 
  check=0
  >&2 echo "Not a valid number : ${arr[$j]}"
  >&1 echo "Usage : calculatePayment.sh <valid_file_name> [More_Files] ... <money>" 
 else 
  int=0
 #2ntbi lm3ra5 momin ykon fi 2shya mish 7oket sl7i
  while [[ $int -lt  $(( $ini - 1 )) ]]     #2f7si el path sho no3o absulty... aw file
   do   
        
        if [ ! -f ${arr[$int]} ]  
        then 
         check=55
         >&2 echo "File does not exist : ${arr[$int]}"
         #exit #2ntbhi lhon b3uzish
        fi  
        int=$(( $int + 1 )) 
   done
 
 fi  
 

if [ $check -eq 55 ]
then 
 >&1 echo "Usage : calculatePayment.sh <valid_file_name> [More_Files] ... <money>"
fi
ii=1
jj=$#
if [ $check -eq 1 ]
then  
 while [[ $ii -le $(( $jj - 1 )) ]] 
 do
    
    while read line ; do
      if [[ $line =~ [0-9\.]+ ]]; then
        echo $BASH_REMATCH
      fi
      
    done <$1 >>to_paycal.txt
    ii=$(( ii + 1 ))
    shift 1

 done
 >&1 awk 'BEGIN { sum=0 } { sum+=$1 } END {printf("Total purchase price : %.2f\n",sum)}' to_paycal.txt
 tot=$(awk 'BEGIN { sum=0 } { sum+=$1 } END {printf("%.2f\n",sum)}' to_paycal.txt) 
 change=`echo "scale=2;(${arr[$j]}-$tot)/1" | bc`
 sign=`echo "$change == 0" | bc`
 if [ $sign -eq 1 ] 
 then 
  >&1 echo "Exact payment"
 else
  add=`echo "$change < 0" | bc`
  if [ $add -eq 1 ]
  then 
   curchange=`echo "$change * -1" | bc`
   >&1 echo "You need to add $curchange shekel to pay the bill"
  else
   >&1 echo "Your change is $change shekel"
  fi
 fi  
 echo > to_paycal.txt
fi
fi
