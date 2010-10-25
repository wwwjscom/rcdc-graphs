namespace :mkt do
	
	desc "Load all market files in the temp folder"
	task :load => [:environment] do
		puts "pre-loop"
		Dir.entries("#{RAILS_ROOT}/tmp/").each do |market_file|

			next unless market_file[/.*market/] != nil
			f = File.open("#{RAILS_ROOT}/tmp/#{market_file}")

			while line = f.gets do
			  market = Market.new
			  market.parse line
			  market.for_date = Date.tomorrow
			  market.save
			end
		end
	end
	
end