# DOCKER-VERSION 0.3.4
# Inspired in http://efemoral.lovius.net/building-haproxy-from-git-on-ubuntu-12-04/
FROM isla/ubuntu-build-tools:python
MAINTAINER Alfonso Fernandez "alfonso@isla.io"
RUN mkdir ~/haproxy_src; cd ~/haproxy_src; wget http://haproxy.1wt.eu/download/1.5/src/devel/haproxy-1.5-dev19.tar.gz; tar zxvf haproxy-1.5-dev19.tar.gz; cd haproxy-1.5-dev19; make TARGET=linux2628 CPU=native USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1; make install
RUN ln -s /usr/local/sbin/haproxy /usr/sbin/haproxy
RUN mkdir /usr/share/haproxy
# RUN wget http://efemoral.lovius.net/wp-content/uploads/2013/02/init.d.haproxy.txt
# RUN mv init.d.haproxy.txt /etc/init.d/haproxy
# RUN chmod +x /etc/init.d/haproxy
# RUN update-rc.d haproxy defaults
RUN echo 'ENABLED=1' >> /etc/default/haproxy
RUN adduser --system --group haproxy
RUN mkdir /etc/haproxy
RUN mkdir /etc/haproxy/errors
RUN cd /etc/haproxy; wget https://raw.github.com/alfonsodev/docker-haproxy/master/haproxy.cfg
# RUN service haproxy start
EXPOSE 80
EXPOSE 443
CMD haproxy -db -f /etc/haproxy/haproxy.cfg
