#!/bin/bash
synoinfo="/etc/synoinfo.conf"
Network() (
#取网口名称
eth=$(ip link | grep ^[0-9] | grep eth[0-9] | awk -F: '{print $2}')
#取网口数量
int=$(echo $eth | grep -o eth | wc -l)
#修改网口数量
sed -i 's/maxlanport="[0-9]"/maxlanport="'$int'"/g' $synoinfo
#计次修改
for ((i=1;i<"$int+1";i++)) ; do
	net=$(echo $eth | awk -F ' ' '{print $'$i' }')
	if [ "${net}" == "eth0" ]; then
		if ! grep -q "${net}_mtu" $synoinfo; then
			sed -i '/sataportcfg/a\'$net'_mtu="1500"' $synoinfo
		fi
		if ! grep -q "${net}_wol" $synoinfo; then
			sed -i '/'$net'_mtu/a\'$net'_wol_options="d"' $synoinfo
		
		fi
	else
		tmp_eth=$(echo $eth | awk -F ' ' '{print $'$(($i-1))' }')
		if ! grep -q "${net}_mtu" $synoinfo; then
			sed -i '/'$tmp_eth'_wol/a\'$net'_mtu=\"1500\"' $synoinfo
		fi
		if ! grep -q "${net}_wol" $synoinfo; then
			sed -i '/'$net'_mtu/a\'$net'_wol_options=\"d\"' $synoinfo
		fi
	fi	
done
)
Network