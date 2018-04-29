ARG CODE_VERSION=1.13.12-alpine
FROM nginx:${CODE_VERSION}
LABEL version="1.0"
RUN apk add wget && apk add unzip
WORKDIR /usr/share/nginx
RUN wget https://wordpress.org/latest.zip
RUN unzip latest.zip
RUN rm -rf latest.zip
RUN mv wordpress/* /usr/share/nginx/
COPY default.conf /etc/nginx/conf.d/default.conf
RUN rm /usr/share/nginx/wp-config.php
ADD wp-config.sh /usr/share/nginx/wp-config.sh
RUN chmod +x /usr/share/nginx/wp-config.sh
RUN chown -R www-data:www-data /usr/share/nginx/
CMD /usr/share/nginx/wp-config.sh
RUN nginx -t
RUN systemctl restart nginx
RUN systemctl status nginx