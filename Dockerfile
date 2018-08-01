FROM    ubuntu:16.04

LABEL   maintainer='Sander Bel <sander@intelliops.be>'

ENV     DEBFULLNAME 'Sander Bel'
ENV     DEBEMAIL 'sander@intelliops.be'
ENV     NRPE_VERSION '2.15'

RUN     echo 'deb-src "http://archive.ubuntu.com/ubuntu/" xenial-updates universe multiverse main restricted' > /etc/apt/sources.list.d/xenial-updates-source.list

RUN     mkdir /build /build-artifacts

WORKDIR /build

RUN     apt-get update --fix-missing && \
        apt-get install -q -y --no-install-recommends dpkg-dev devscripts equivs && \
        apt-get source nagios-nrpe-server && \
        mv nagios-nrpe-${NRPE_VERSION} source && \
        rm -rf /var/lib/apt/lists/*

WORKDIR /build/source

RUN     apt-get update --fix-missing && \
        mk-build-deps -i -t 'apt-get -o Debug::pkgProblemResolver=yes -q -y --no-install-recommends' && \
        rm -rf /var/lib/apt/lists/*

COPY    99_privileged_ports.dpatch debian/patches/

RUN     echo '99_privileged_ports.dpatch' >> debian/patches/00list

RUN     dch -i 'Added support for privileged ports through authbind.' && \
        dch -r xenial

VOLUME  ["/build-artifacts"]

CMD     ["/bin/bash", "-c", "debuild -uc -us && mv ../nagios-nrpe* /build-artifacts"]
