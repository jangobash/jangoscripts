#!/bin/bash
ZAHL=$1
SCALER=204.6

VAR1=`curl -s http://jansnicfortest/ecmd?adc%20get | awk '{print $'$ZAHL'}'`
VARDEC1=`printf '%d' 0x$VAR1`
printf "%.2f\n" $(echo "scale=2 ; $VARDEC1/$SCALER" |bc|tr . , )
