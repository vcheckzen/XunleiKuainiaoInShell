# XunleiKuainiaoInShell

## Introduction

A shell implementation of kuainiao, xunlei, runs properly on almost all linux platform.

## How to Use

### Bind Your Xunlei with Mi Accout

Because the code is using mi account to authorize xunlei, you should bind them first. Here is [the guide](https://www.crsky.com/zixun/34451.html).

### Download the Code

Assuming you've installed git, then

```bash
git clone https://github.com/vcheckzen/XunleiKuainiaoInShell.git
cd XunleiKuainiaoInShell
```

### Edit the Code, Add Your Mi Account

Change `XXXXXXXXXXX` with your mi account username and password in `kuainiao.sh`.

```bash
# Line 8 and 9 of kuainiao.sh
user="XXXXXXXXXXX"
passwd="XXXXXXXXXXX"
```

### Install Requirements and Test Environment

```bash
# Requirements on OpenWRT, Padavan and other RouterOS based on entware or optware environment
opkg update && opkg install libreadline libcurl libopenssl bash curl wget openssl-util ca-certificates ca-bundle

# Normal output: "ip":"121.226.150.154"
curl -s https://ipconfig.io/json | grep -Eo "\"ip\":\"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\""
wget -qO- https://ipconfig.io/json | grep -Eo "\"ip\":\"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\""
```

### Run `kuainiao.sh` to Test

```bash
chmod +x kuainiao.sh browser.sh

# Speed up
./kuainiao.sh

# Revocer
./kuainiao.sh 0
```

### Set `kuainiao.sh` As a Cron Job

The code below will enable `kuainiao.sh` to run one time in an hour, noting that `certain_directory` should be replaced.

```bash
crontab -l > tmp && echo "1 * * * * /certain_directory/kuainiao/kuainiao.sh" >> tmp && crontab tmp && rm -f tmp
```

# References

- [Xunlei-Fastdick](https://github.com/fffonion/Xunlei-Fastdick)
- [luci-app-xlnetacc](https://github.com/sensec/luci-app-xlnetacc)