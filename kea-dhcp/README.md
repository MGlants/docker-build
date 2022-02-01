# kea-dhcp

[![Docker Pulls](https://img.shields.io/docker/pulls/smailkoz/kea-dhcp?logo=docker)](https://hub.docker.com/r/smailkoz/kea-dhcp)
[![Github Package](https://img.shields.io/static/v1?label=MGlants&message=Github%20Package&color=blue&logo=github)](https://github.com/MGlants/docker-build/tree/main/kea-dhcp)
![Docker Image Size (latest)](https://img.shields.io/docker/image-size/smailkoz/kea-dhcp/latest?label=latest%20size)
[![kea-dhcp chart version](https://img.shields.io/badge/dynamic/yaml?url=https://charts.glants.xyz/index.yaml&label=kea-dhcp&query=$.entries['kea-dhcp'][:1].version&color=277A9F&logo=helm)](https://artifacthub.io/packages/helm/mglants/kea-dhcp)

Docker image for kea-dhcp with amd64 and arm64
* Built specifically for [helm-chart](https://artifacthub.io/packages/helm/mglants/kea-dhcp) 
* Small Alpine 3.13 based Image
* Memfile, MySQL, Postgres backend can be used
* kea-shell included
* [kea-exporter](https://github.com/mweinelt/kea-exporter) included 
* DHCP6 support included
* Semantic versioning

## Usage

### Use memfile

Create dir and files.

```shell
mkdir -p kea-dhcp/conf
cd kea-dhcp
touch conf/kea-dhcp4.conf
mkdir leases
touch dhcp4.leases
touch docker-compose.yml
```

`docker-compose.yml`(same as `examples/docker-compose.file.yaml`):

```yaml
version: "3"
services:
  kea-dhcp:
    image: smailkoz/kea-dhcp
    volumes:
      - "$PWD/conf/kea-dhcp4.conf:/etc/kea/kea-dhcp4.conf"
      - "$PWD/conf/leases:/var/lib/kea"
    restart: always
    network_mode: host
    container_name: kea-dhcp
```

`conf/kea-dhcp4.conf`:

For more DHCP4 settings: [https://kea.readthedocs.io/en/latest/arm/dhcp4-srv.html](https://kea.readthedocs.io/en/latest/arm/dhcp4-srv.html)

```json
{
  "Dhcp4": {
    "valid-lifetime": 43200,
    "renew-timer": 1000,
    "rebind-timer": 2000,

    "interfaces-config": {
      "interfaces": ["eth0"]
    },

    "lease-database": {
      "type": "memfile",
      "persist": true,
      "name": "/var/lib/kea/dhcp4.leases"
    },

    "subnet4": [
      {
        "subnet": "192.168.1.0/24",
        "pools": [
          {
            "pool": "192.168.1.1 - 192.168.1.255"
          }
        ]
      }
    ]
  }
}
```

### Use MariaDB or PostgreSQL



```yaml
version: "3"
services:
  kea-dhcp:
    image: smailkoz/kea-dhcp
    volumes:
      - "$PWD/conf/kea-dhcp4.conf:/etc/kea/kea-dhcp4.conf"
    restart: always
    network_mode: host
    container_name: kea-dhcp
    depends_on: 
      - mariadb

  mariadb:
    image: yobasystems/alpine-mariadb
    environment:
      - MYSQL_DATABASE=keadhcp4
      - MYSQL_ROOT_PASSWORD=keapassword
      - MYSQL_USER=keauser
      - MYSQL_PASSWORD=keapassword
    volumes:
      - "$PWD/conf/db:/var/lib/mysql"
    ports:
      - 3306:3306
    restart: always
    container_name: kea-mariadb
```

Edit `lease-database` part in `conf/kea-dhcp4.conf`:

```json
"lease-database": {
    "type": "mysql",
    "host": "127.0.0.1",
    "port": 3306,
    "name": "keadhcp4",
    "user": "keauser",
    "password": "keapassword"
}
```