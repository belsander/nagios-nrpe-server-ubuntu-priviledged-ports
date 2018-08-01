# nagios-nrpe-server-ubuntu-privileged-ports
Nagios NRPE server for Ubuntu Xenial to run on privileged ports

If you are having the same corporate firewall issues, then default NRPE port 5667 cannot be used. The only ports that are however available are privileged ports in that case ( =< 1024). With this patch, nagios-nrpe-server can run on privileged ports through authbind. Documentation can be found back in /etc/nagios/nrpe.cfg.

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
# Get source from xenial-updates (currently 2.15-ubuntu1.1)
echo 'deb-src "http://archive.ubuntu.com/ubuntu/" xenial-updates universe multiverse main restricted' > /etc/apt/sources.list.d/xenial-updates-source.list
apt-get update
mkdir /tmp/build
cd /tmp/build
apt-get source nagios-nrpe-server

# Get patches for privileged ports
git clone https://github.com/belsander/nagios-nrpe-server-ubuntu-privileged-ports patches
cd nagios-nrpe-2.15
cp ../patches/00list debian/patches/00list
cp ../patches/11_privileged_ports.dpatch debian/patches/

# Build package
debuild -us -uc

cd ..
pbuilder create --distribution xenial  --debootstrapopts --variant=buildd  --othermirror "deb http://archive.ubuntu.com/ubuntu xenial universe"
pbuilder build nagios-nrpe_2.15-1ubuntu1.2.dsc
```
