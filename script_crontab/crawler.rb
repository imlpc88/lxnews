#!/usr/local/rvm/rubies/ruby-1.9.3-p545/bin/ruby

require 'rss/2.0'
require 'open-uri'
require 'mysql2'
require 'lanxin_open'

LanxinOpen.config do
  host "https://open-dev.lanxin.cn"
  port ""
  use_new_json true
end

def get_post_id(cli)
	sql = "select id from posts where id in \(select max\(id\) from posts\)"
	results = cli.query(sql)
	return results.first["id"]
end


def get_news_id(cli)
	sql = "select id from news where id in \(select max\(id\) from news\)"
	results = cli.query(sql)
	return results.first["id"]
end

def insert_to_posts(cli)
	sql = "insert into posts (timestr, created_at, updated_at) values (\'#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}\', \'#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}\', \'#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}\')"
	cli.query(sql)
end

def get_link_array(cli)
	sql = "select link from news"
	arr = []
	results = cli.query(sql)
	results.each do |hash|
		arr << hash["link"]
	end
	return arr
end

def insert_to_news(cli,title, link, img, post_id)
	sql = "insert into news (title, link, img, created_at, updated_at, post_id) values (\'#{title}\', \'#{link}\', \'#{img}\', \'#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}\', \'#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}\', #{post_id})"
	cli.query(sql)
	sql = ""
end

client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => "")
client.query("use dev_mysql2")
insert_to_posts(client)
post_id = get_post_id(client)
puts post_id
news_id_before_insert = get_news_id(client)
url = 'http://news.qq.com/newsgn/rss_newsgn.xml'
feed = RSS::Parser.parse(open(url).read, false)
img = "http://lxhelp.wqapp.cn/helplx_uploads/KEY_3002_DianxingAnli-1/zhongtiejian.png"
links_array = get_link_array(client)

feed.items.each do |item|
	insert_to_news(client, item.title, item.link, img, post_id) unless links_array.include?(item.link) || ((news_id_before_insert+4) == get_news_id(client))
end

client.close

puts "new data has inserted into db."
token = "lxnews"
devkey = "111111"
from_user = 100147
open_id = "18611083570" #"18600598413" "18611083570" "18710842198"

org_id = 1239
struct_id = "497713"
 
open = LanxinOpen.new
open.dump_config
 
skey = open.fetch_skey(token,devkey)
puts "fetch skey: #{skey}"
puts "open skey: #{open.skey}"

push_uri = "http://115.28.218.69:8080/posts/#{post_id}.json?count=4"
puts "push_uri: " + push_uri
res = open.send_pictext_msg(push_uri, open_id, "#{feed.items.first.title}", from_user)
puts "send pic msg return #{res}"
res = open.send_pictext_msg(push_uri, "18710842198", "testPic", from_user)
puts "send pic msg return #{res}"

