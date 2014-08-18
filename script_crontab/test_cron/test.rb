#!/usr/local/rvm/rubies/ruby-1.9.3-p545/bin/ruby

`source ~/.bashrc`

require 'nokogiri'
url = "http://news.qq.com/a/20140815/021391.htm"
`wget #{url} -O tmp.htm -o nothing.log`
doc = Nokogiri::HTML(File.read('tmp.htm'))
puts "img1: #{doc.xpath('//img')[1].attributes()["src"].value()}"

# */1 * * * * /var/www/lxnews/script_crontab/test_cron/test.rb >> /var/www/lxnews/script_crontab/test_cron/test.log
