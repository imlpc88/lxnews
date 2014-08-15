require 'mysql2'

def get_news_id(client)
	sql = "select id from news where id in \(select max\(id\) from news\)"
	results = client.query(sql)
	return results.first["id"]
end

client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => "")
client.query("use dev_mysql2")

puts get_news_id(client)
client.close
