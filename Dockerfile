FROM ubuntu:16.04
RUN apt-get update -y
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common apt-utils
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update -y
RUN apt-get install -y apache2 php7.0 libapache2-mod-php7.0 php7.0-mysql mysql-client php7.0-mcrypt php7.0-curl php7.0-gd php7.0-xml php7.0-zip openssl wget curl php7.0-imap php7.0-mbstring php7.0-soap vim libpng12-dev libjpeg-dev
RUN mkdir /usr/src/vtiger && cd /usr/src/vtiger && rm -rf /usr/src/vtiger/* && curl -o vtiger.tar.gz -L "https://sourceforge.net/projects/vtigercrm/files/vtiger%20CRM%207.0/Core%20Product/vtigercrm7.0.0.tar.gz"
COPY test.sh /usr/src/vtiger/
RUN /usr/src/vtiger/test.sh
#COPY vtigercrm6.5.0.tar.gz /usr/src/vtiger
RUN cd /usr/src/vtiger && rm -rf /var/www/html/index.html && tar -xf /usr/src/vtiger/vtiger.tar.gz && cp -av /usr/src/vtiger/vtigercrm/* /var/www/html/ && chmod -R 777 /var/www/html && chown -R www-data:www-data /var/www/html/ && a2enmod rewrite && service apache2 restart
RUN apt-get clean && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

WORKDIR /var/www/html
EXPOSE 80 443
CMD ["apachectl", "-D", "FOREGROUND"]