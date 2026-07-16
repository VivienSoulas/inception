FROM debian:bookworm

RUN apt update && \
    apt install -y \
        php-fpm \
        php-mysql \
		php-cli \
        mariadb-client \
        curl

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY tools/init_wp.sh /usr/local/bin/init_wp.sh

RUN chmod +x /usr/local/bin/init_wp.sh

ENTRYPOINT ["/usr/local/bin/init_wp.sh"]