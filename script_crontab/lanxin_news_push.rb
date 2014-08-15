gem "lanxin_open"
require "lanxin_open"

LanxinOpen.config do
	host "https://open-dev.lanxin.cn" 
	port ""
	use_new_json true
end

def test_send_text(open,open_id,from_user)
  res = open.send_text_msg("test text----",open_id,from_user)
  puts "send text msg return #{res}"
end

def test_send_pictext(open,open_id,from_user)
  res = open.send_pictext_msg("http://210.14.147.169/pictext/msg_json/KEY_3002_DianxingAnli?count=4",open_id,"testPic",from_user)
  puts "send pic msg return #{res}"
end

token = "lxnews"
devkey = "111111"
from_user = 100147
open_id = "18710842198" #"18600598413" "18611083570"

org_id = 1239
struct_id = "497713"

open = LanxinOpen.new
open.dump_config

skey = open.fetch_skey(token,devkey)
puts "fetch skey: #{skey}"
puts "open skey: #{open.skey}"

# test_send_text(open,open_id,from_user)
# test_send_pictext(open,open_id,from_user)

# uri address:
# http://115.28.218.69:8080/news/show
push_uri =  http://115.28.218.69:8080/posts/#{post_id}

res = open.send_pictext_msg(push_uri, open_id, "testPic", from_user)
puts "send pic msg return #{res}"
