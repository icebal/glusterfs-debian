FROM ubuntu:bionic
ENV SERIES 6
ENV VERSION $SERIES.0
ENV RELEASE 1
ENV GPG_KEY
COPY debian .
RUN apt install gnupg dput dh-make devscripts lintian pbuilder debuilder debdelta && \
	mkdir build packages glusterfs-$VERSION-$RELEASE && \
	wget http://download.gluster.org/pub/gluster/glusterfs/${SERIES}/${VERSION}/glusterfs-${VERSION}.tar.gz && \
	ln -s glusterfs-$VERSION.tar.gz glusterfs_$VERSION.orig.tar.gz && \
	tar xzf glusterfs-$VERSION.tar.gz && \
	cd glusterfs-$VERSION && \
	cp ../debian . && \
	debuild -S -sa -k $GPG_KEY && \
	dput ppa:icebal-7/glusterfs-6 glusterfs_$VERSION-$RELEASE*.changes
VOLUME /root/.gnupg
