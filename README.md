# XunleiKuainiaoInShell

## Introduction
A Shell Implementation of Kuainiao, Xunlei.

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
wget https://github.com/vcheckzen/XunleiKuainiaoInShell/archive/master.zip
unzip master.zip
cd master
```

### Edit the Code, Add Your Mi Account

Change `XXXXXXXXXXX` with your mi account username and password at line 13, 14 in `kuainiao.sh`

```bash
# line 13 and  14 of kuainiao.sh
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

The code below will enable kuainiao.sh to run one time in an hour, but the best way is to run it on ip change, your can implement it by yourself.

```bash
crontab -l > tmp && echo "1 * * * * /certain_directory/kuainiao.sh" >> conf && crontab tmp && rm -f tmp
```