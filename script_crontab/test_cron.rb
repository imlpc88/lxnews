require 'rufus-scheduler'
scheduler = Rufus::Scheduler.new

puts Time.new
puts 'process begin----'
scheduler.cron '0 17-20 * * *' do
  puts Time.new
	`ruby ./crawler.rb`
end
scheduler.join

