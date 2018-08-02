# nagios-nrpe-server-ubuntu-privileged-ports
[![Build status](https://img.shields.io/travis/belsander/nagios-nrpe-server-ubuntu-privileged-ports.svg)](https://travis-ci.org/belsander/nagios-nrpe-server-ubuntu-privileged-ports)

Nagios NRPE server for Ubuntu Xenial to run on privileged ports

If you are having the same corporate firewall issues, then default NRPE port 5666 cannot be used. The only ports that are however available are privileged ports in that case ( =< 1024). With this patch, nagios-nrpe-server can run on privileged ports through authbind. Documentation can be found back in /etc/nagios/nrpe.cfg.

Or in short:
```
touch /etc/authbind/byport/<PORT>
chmod 0755 /etc/authbind/byport/<PORT>

vim /etc/nagios/nrpe.cfg
...
server_port=<PORT>
...
```

## Build
```
git clone https://github.com/belsander/nagios-nrpe-server-ubuntu-privileged-ports nagios-nrpe-server
cd nagios-nrpe-server
docker build --tag nagios-nrpe-server-builder .
mkdir /tmp/nagios-nrpe-server-build
docker run -v /tmp/nagios-nrpe-server-build:/build-artifacts nagios-nrpe-server-builder
ls -alh /tmp/nagios-nrpe-server-build
```
