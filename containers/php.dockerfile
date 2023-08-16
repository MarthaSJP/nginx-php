FROM php:7-fpm

COPY ./src /var/www/html

# New RelicのAPMエージェントの導入
RUN \
  curl -L https://download.newrelic.com/php_agent/release/newrelic-php5-10.11.0.3-linux.tar.gz | tar -C /tmp -zx && \
  export NR_INSTALL_USE_CP_NOT_LN=1 && \
  export NR_INSTALL_SILENT=1 && \
  /tmp/newrelic-php5-*/newrelic-install install && \
  rm -rf /tmp/newrelic-php5-* /tmp/nrinstall* && \
  sed -i \
       # New Relicのライセンスキーの設定
       -e 's/"REPLACE_WITH_REAL_KEY"/"${NEW_RELIC_LICENSE_KEY}"/' \
       # New Relicで表示されるアプリケーションの名称
       -e 's/newrelic.appname = "PHP Application"/newrelic.appname = "Docker PHP Application"/' \
       -e 's/;newrelic.daemon.app_connect_timeout =.*/newrelic.daemon.app_connect_timeout=15s/' \
       -e 's/;newrelic.daemon.start_timeout =.*/newrelic.daemon.start_timeout=5s/' \
       /usr/local/etc/php/conf.d/newrelic.ini