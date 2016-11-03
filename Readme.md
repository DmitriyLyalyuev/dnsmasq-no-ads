Local DNSMasq DNS server with ads filter
========================================

### Original repo

It is mirror of [original repo](https://git.lyalyuev.info/silver/dnsmasq-no-ads)

### Dependensies:

* [docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)

### Spin up:

#### Clone repo

```bash
sudo mkdir /opt/docker
sudo chown <user> /opt/docker
git clone https://git.lyalyuev.info/silver/dnsmasq-no-ads /opt/docker/dnsmasq
cd /opt/docker/dnsmasq
```

#### Run your own DNS server with ads filter

```bash
docker-compose up -d
```

### Update ads lists:

To update database run just restart container

```bash
docker-compose restart dnsmasq
```

### White listing:

White list of domains you can specify on environment variable WHITE_LIST in docker-compose.yml file.
