FROM ubuntu:bionic
ENV SERIES 6
ENV VERSION $SERIES.0
ENV RELEASE 1
ENV GPG_KEY 0
COPY debian /root/debian
RUN  ls && apt update && apt -y upgrade && apt -y install gpg dput dh-make devscripts lintian pbuilder debdelta libfuse-dev libibverbs-dev libdb-dev librdmacm-dev libaio-dev libacl1-dev libsqlite3-dev liburcu-dev uuid-dev liblvm2-dev libattr1-dev flex bison libreadline-dev libncurses5-dev libglib2.0-dev libssl-dev libxml2-dev pkg-config dh-systemd dh-python python3-all-dev && \
	mkdir build packages glusterfs-$VERSION-$RELEASE && \
	wget http://download.gluster.org/pub/gluster/glusterfs/${SERIES}/${VERSION}/glusterfs-${VERSION}.tar.gz && \
	ln -s glusterfs-$VERSION.tar.gz glusterfs_$VERSION.orig.tar.gz && \
	tar xzf glusterfs-$VERSION.tar.gz && \
	cd glusterfs-$VERSION && \
	cp -r /root/debian . && \
	debuild -S -sa -k $GPG_KEY && \
	dput ppa:icebal-7/glusterfs-6 glusterfs_$VERSION-$RELEASE*.changes
VOLUME /root/.gnupg
