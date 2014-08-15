require 'mysql2'


def get_post_id(client)
	sql = "select id from posts where id in \(select max\(id\) from posts\)"
	results = client.query(sql)
	return results.first["id"]
end

client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => "")
client.query("use dev_mysql2")

puts get_post_id(client)
client.close

# database => "development_mysql2"
# "insert into news (title, link, img,created_at, updated_at, post_id) values ("jiangFuck", "http://sth.com/jiangFuck.html", "http://sth.com/jiangFuck.jpg", date_format(now(), '%Y-%c-%d %h:%i:%s'), date_format(now(), '%Y-%c-%d %h:%i:%s'), 1)"
=begin
results = client.query("select * from news");
results.each do |hash|
	puts hash.map { |k,v| "#{k} = #{v}"}.join(", ")
end
=end
