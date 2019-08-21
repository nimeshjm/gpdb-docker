FROM 	pivotaldata/gpdb-dev:centos7 as builder

ADD 	5.21.2.sha256 ./

RUN	wget -q https://github.com/greenplum-db/gpdb/archive/5.21.2.tar.gz && \
	sha256sum -c 5.21.2.sha256 --status && \
	tar xzf 5.21.2.tar.gz

WORKDIR /gpdb-5.21.2

RUN	source /opt/rh/devtoolset-6/enable && \
	./configure --enable-debug --with-perl --with-python --with-libxml --disable-orca --prefix=/usr/local/gpdb && \
	make -j4 && \
	make install

FROM 	pivotaldata/gpdb-dev:centos7 

COPY 	--from=builder /usr/local/gpdb/ /usr/local/gpdb/

RUN	pip install --no-cache-dir paramiko && \
	echo -e 'source /usr/local/gpdb/greenplum_path.sh' >> /root/.bashrc

USER 	gpadmin

WORKDIR	/home/gpadmin

VOLUME	/home/gpadmin/demo

ADD 	--chown=gpadmin:gpadmin entrypoint.sh ./

ADD 	--chown=gpadmin:gpadmin demo/ /home/gpadmin/demo/

RUN	echo -e 'source /usr/local/gpdb/greenplum_path.sh' >> /home/gpadmin/.bashrc

WORKDIR	/home/gpadmin/demo

EXPOSE 15432/tcp


ENTRYPOINT ["/home/gpadmin/entrypoint.sh"]
