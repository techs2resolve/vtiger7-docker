FROM ubuntu:16.04
RUN apt-get update -y
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common apt-utils && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && apt-get update -y && apt-get install -y apache2 php5.6 libapache2-mod-php5.6 php5.6-mysql mysql-client php5.6-mcrypt php5.6-curl php5.6-gd php5.6-xml php5.6-zip openssl wget curl php5.6-imap php5.6-mbstring php5.6-soap vim libpng12-dev libjpeg-dev
RUN mkdir /usr/src/vtiger && cd /usr/src/vtiger && rm -rf /usr/src/vtiger/* && curl -o vtiger.tar.gz -L "https://sourceforge.net/projects/vtigercrm/files/vtiger%20CRM%207.0.1/Core%20Product/vtigercrm7.0.1.tar.gz"
COPY test.sh /usr/src/vtiger/
RUN chmod 777 /usr/src/vtiger/test.sh && sh /usr/src/vtiger/test.sh
RUN cd /usr/src/vtiger && rm -rf /var/www/html/index.html && tar -xf /usr/src/vtiger/vtiger.tar.gz && cp -av /usr/src/vtiger/vtigercrm/* /var/www/html/ && chmod -R 777 /var/www/html && chown -R www-data:www-data /var/www/html/ && a2enmod rewrite && service apache2 restart
RUN apt-get clean && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

WORKDIR /var/www/html
EXPOSE 80 443
CMD ["apachectl", "-D", "FOREGROUND"]
