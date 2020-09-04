#!/bin/bash
tab[0]=10.61.24.60
tab[1]=10.61.24.160
tab[2]=10.61.24.161
tab[3]=10.61.24.163
tab[4]=10.61.24.63
tab[5]=10.61.24.64
tab[6]=10.61.24.167
tab[7]=10.61.24.169
tab[8]=10.61.24.36
tab[9]=10.61.24.30
tab[10]=10.62.24.31
tab[11]=10.62.24.32
tab[12]=10.62.24.52
tab[13]=10.62.24.33
tab[14]=10.62.24.34
tab[15]=10.62.24.37
tab[16]=10.62.24.11
tab[17]=10.62.24.56
tab[18]=10.62.24.53
tab[19]=10.62.24.46
tab[20]=10.62.24.174
tab[21]=10.62.24.241
tab[22]=10.62.24.242
tab[23]=10.62.24.73
tab[24]=10.62.24.74
tab[25]=10.62.24.79
tab[26]=10.34.20.21
tab[27]=10.62.02.21
tab[28]=10.34.20.11
tab[29]=10.62.02.11
tab[30]=10.62.24.91
tab[31]=10.62.24.120
tab[32]=10.62.24.121
tab[33]=10.62.24.92
tab[34]=10.62.24.95
tab[35]=10.62.24.96
tab[36]=10.62.24.97
tab[37]=10.62.24.98
tab[38]=10.62.24.110
tab[39]=10.62.24.111
tab[40]=10.62.24.191
tab[41]=10.62.24.192
tab[42]=10.62.24.193
tab[43]=10.62.24.194
tab[44]=10.62.24.195
tab[45]=10.62.24.196
tab[46]=10.62.24.197
tab[47]=10.62.24.198
tab[48]=10.62.24.199
tab[49]=10.62.24.200
tab[50]=10.62.24.190
tab[51]=10.62.24.189
tab[52]=10.62.24.181
tab[53]=10.62.24.94
tab[55]=10.62.24.180
tab[56]=10.62.24.182
tab[57]=10.62.24.183
tab[58]=10.62.24.185
tab[59]=10.62.24.29
tab[60]=10.62.24.20
tab[61]=10.62.24.21
tab[62]=10.62.24.22
tab[63]=10.62.24.23
tab[64]=10.62.24.50
tab[65]=10.62.24.76
tab[66]=10.62.24.77
tab[67]=10.62.24.226
tab[68]=10.62.24.227
tab[69]=10.62.24.103
tab[70]=10.02.20.76
tab[71]=10.62.24.237
tab[72]=10.62.24.238
tab[73]=10.34.20.101
tab[74]=10.62.24.105
tab[75]=10.62.24.125
tab[76]=10.62.24.126
tab[77]=10.62.24.127
i=1
while (( $i < ${#tab[*]} )); do
ping -c 3 ${tab[$i]} -q
tabR[$i]=${?};
i=$((i+1));
done
clear

i=1
while (( $i < ${#tab[*]} )); do
if [ ${tabR[$i]} -eq 0 ];
then echo " ${tab[$i]} Répond correctement au ping ! "
else echo " ${tab[$i]} Ne répond pas, vérifier l'état de votre machine !!!"
fi
i=$((i+1));
done
