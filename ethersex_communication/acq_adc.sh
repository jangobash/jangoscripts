#!/bin/bash
#jg, 14.06.2012

#Host Adresse
NETIO_URL=xx.xx.xx.xx
USER_NAME=blaba
PASS_WORD=blaba
SCALE_ADC0=204.6
DIM_ADC0=V
SCALE_ADC1=204.6
DIM_ADC1=V
SCALE_ADC2=204.6
DIM_ADC2=V
SCALE_ADC3=204.6
DIM_ADC3=V
SCALE_ADC4=40
DIM_ADC4=Volt
SCALE_ADC5=204.6
DIM_ADC5=kV
SCALE_ADC6=204.6
DIM_ADC6=V
SCALE_ADC7=204.6
DIM_ADC7=mA

#################
if ping -w 5 -c 1 $NETIO_URL > /dev/null
    then 
    sleep 0.01
    else
    echo "host nicht erreichbar"
    exit 0
fi

if ([[ "$1"  <"4" ]] || [[ "$1" >"7" ]]) 
    then
    echo "port not available / active: 4 5 6 7"
    exit 1
fi

#################
SPALTE=$(($1 + 1))
ADCPORT=$1
#funktion acq_adc liest von ethersexdevice die adc zustände. ZAHL ist der parameter aus shellübergabe
acq_adc() {
          ZAHL=$1
          SCALER=204.6
          VAR1=`curl -u $USER_NAME:$PASS_WORD -s http://$NETIO_URL/ecmd?adc%20get | cut -d' ' -f$ZAHL`
          VARDEC1=`printf '%d' 0x$VAR1`
          SCALE="SCALE_ADC$ADCPORT"
          DIM="DIM_ADC$ADCPORT"
          printf "%.1f ${!DIM}\n" $(echo "scale=2 ; $VARDEC1/${!SCALE}" |bc|tr . , ) # ($!SCALE definiert explizite Variable)
}

#acq_adc aufrufen mit erstem übergebenem Parameter aus shell
acq_adc $SPALTE

