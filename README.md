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
# line 8 and 9 of `kuainiao.sh`
user="XXXXXXXXXXX"
passwd="XXXXXXXXXXX"
```

### Run `kuainiao.sh` to Test

```bash
# requirements on OpenWrt, Padavan and other RouterOS based on entware or optware environment
opkg update && opkg install libreadline libcurl libopenssl bash curl wget openssl-util ca-certificates ca-bundle

chmod +x kuainiao.sh browser.sh

# speed up
./kuainiao.sh

# revocer
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