#!/bin/bash

cd /var/www/lxnews

source /root/.bash_profile

echo "fetch news " >> /var/www/lxnews/fetch_news.log 2>&1

/usr/local/rvm/rubies/ruby-1.9.3-p545/bin/ruby /var/www/lxnews/script_crontab/crawler.rb
