# XunleiKuainiaoInShell

## Introduction

A shell implementation of kuainiao, xunlei, which can be used in almost all linux platform.

## How to Use

### Bind Your Xunlei with Mi Accout

Because the code is using mi account to authorize xunlei, you should bind them first. Here is [the guide](https://www.crsky.com/zixun/34451.html).

### Download the Code

If you've installed git, then

```bash
git clone https://github.com/vcheckzen/XunleiKuainiaoInShell.git
cd XunleiKuainiaoInShell
```
Or

```bash
wget https://github.com/vcheckzen/XunleiKuainiaoInShell/archive/v1.0.tar.gz
tar -zxvf v1.0.tar.gz
rm -f v1.0.tar.gz
cd XunleiKuainiaoInShell-1.0
```

### Edit the Code, Add Your Mi Account

Change `XXXXXXXXXXX` with your mi account username and password at line 13, 14 in `kuainiao.sh`.

```bash
# line 13 and 14 of kuainiao.sh
user="XXXXXXXXXXX"
passwd="XXXXXXXXXXX"
```

### Run kuaniao.sh to Test

```bash
chmod 777 kuainiao.sh

# speed up
./kuainiao.sh

# revocer
./kuainiao.sh 0
```

### Set kuainiao.sh As a Cron Job

The code below will enable kuainiao.sh to run one time in an hour, note that `certain_directory` should be replaced.

```bash
crontab -l > tmp && echo "1 * * * * /certain_directory/kuainiao/kuainiao.sh" >> tmp && crontab tmp && rm -f tmp
```

### Run the Code According to WAN IP Change

Actually, the best way is to run the code on IP change, below is an example.

```bash
#!/bin/bash

wan_interface="ppp0"
base_dir=`dirname $0`
data_dir="$base_dir/data"
old_ip_file="$data_dir/ip"
kuainiao="$base_dir/kuainiao.sh"
[ ! -d "$data_dir" ] && mkdir -p "$data_dir"
[ ! -f "$old_ip_file" ] && touch "$old_ip_file"


old_ip="`cat $old_ip_file`"
new_ip="`ifconfig "$wan_interface" | grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | head -1`"
if [ "$old_ip" != "$new_ip" ]; then
    "$kuainiao"
    echo "$new_ip" > "$old_ip_file"
fi
```

Save the code above to maintain.sh and move it to the same directory of kuainiao.sh. Then, Add it to Cron.

```bash
chmod 777 maintain.sh
crontab -l > tmp && echo "* * * * * /certain_directory/kuainiao/maintain.sh" >> tmp && crontab tmp && rm -f tmp
```