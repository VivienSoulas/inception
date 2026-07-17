FROM debian:bookworm

RUN apt update && apt install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/init_nginx.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/init_nginx.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/init_nginx.sh"]