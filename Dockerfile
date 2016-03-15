FROM resin/rpi-raspbian:latest

RUN apt-get update && apt-get install -y wget libsqlite3-0 libglib2.0-0 libical1a libudev1 libjson-glib-1.0-0 libc6 libncurses5 libncurses5-dbg libtinfo5 libtinfo5-dbg libstdc++6 libpcrecpp0 libselinux1 libffi6 libsoup2.4-1 libglib2.0-dev libdbus-1-dev libudev-dev automake libtool libical-dev libreadline-dev git make
RUN cd /opt && git clone --depth 1 git://git.kernel.org/pub/scm/bluetooth/bluez.git
RUN cd /opt/bluez && ./bootstrap
RUN cd /opt/bluez && ./configure --enable-experimental --enable-library
RUN cd /opt/bluez && make
RUN cd /opt/bluez && make install
RUN mkdir /opt/flic && cd /opt/flic && wget --no-check-certificate https://github.com/50ButtonsEach/fliclib-linux-dist/releases/download/1-beta3/fliclib-linux.tar.gz
RUN cd /opt/flic && tar xvfz fliclib-linux.tar.gz
RUN apt-get install dbus
COPY runfile /opt/