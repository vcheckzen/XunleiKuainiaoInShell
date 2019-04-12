#!/bin/bash

base_dir=`dirname $0`
source "$base_dir/browser.sh"
data_dir="$base_dir/data"
[ ! -d "$data_dir" ] && mkdir -p "$data_dir"
mi="$data_dir/mi"
phash="$data_dir/hash"
cookies="$data_dir/cookies"


# 小米账号和密码
user="XXXXXXXXXXX"
passwd="XXXXXXXXXXX"


xunlei_mi_auth="https://open-api-auth.xunlei.com/platform?m=BindOauth"
mi_oauth=`get "$xunlei_mi_auth" | grep -Eo "http.+[0-9]"`
getFollowRedirect "$mi_oauth" > "$mi"
sid="sid=oauth2.0"
callback=`cat "$mi" | grep -Eo "callback:.+oauth2.0\"" | grep -Eo "http.+oauth2.0"`
qs=`cat "$mi" | grep -Eo "qs:.+\"" | grep -Eo "\".+\"" | sed 's/\"//g'`
_sign=`cat "$mi" | grep -Eo "\"_sign.+\"" | grep -Eo "\"[^_:].+\"" | sed 's/\"//g'`
qs=qs=`urlencode "$qs"`
_sign=_sign=`urlencode "$_sign"`
callback=callback=`urlencode "$callback"`


mi_auth="https://account.xiaomi.com/pass/serviceLoginAuth2"
user="user=$user"
if [ ! -f "$phash" ]; then
    hash="hash=`echo -n $passwd | md5sum | awk '{print $1}' | tr 'a-z' 'A-Z'`"
    echo "$hash" > "$phash"
else
    hash=`cat "$phash"`
fi
xunlei_auth=`post "$mi_auth" "$user&$hash&$sid&$callback&$qs&$_sign" | grep -Eo "http.+'" | sed "s/'//"`
saveCookies "$xunlei_auth" "$cookies"
sessionid=sessionid=`cat "$cookies" | grep -Eo "ws.+"`
userid=userid=`cat "$cookies" | grep userid | grep -Eo "[0-9]+" | tail -1`
user_type=user_type="1"
peerid=peerid="5c6b3947-b48c-43ea-b821-72fa73e3e186"
client_type=client_type="guanwang-huodongweb-1.0"


xunlei_portal="http://api.portal.swjsq.vip.xunlei.com:81/v2/queryportal"
kuainiao_speeder=`get "$xunlei_portal"`
host=host=`echo "$kuainiao_speeder" | grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"`
port=port=`echo "$kuainiao_speeder" | grep -Eo "[0-9]+" | tail -1`
kuainiao_transfer="https://xlkn-ssl.xunlei.com/"
dial_account=dial_account=`get "${kuainiao_transfer}bandwidth?$host&$port&$peerid&$sessionid&$userid&$client_type" | grep -Eo "\"dial_account.+[0-9]+\"" | grep -Eo "[0-9]+"`
method="upgrade"
[ "$1" = "0" ] && method="recover"
get "$kuainiao_transfer$method?$host&$port&$user_type&$dial_account&$peerid&$sessionid&$userid&$client_type"
