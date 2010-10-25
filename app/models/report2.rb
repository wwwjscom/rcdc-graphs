class Report2 < ActiveRecord::Base
	
	SUPPLY_HOSTS = ["Market", "1V", "ALL", "DCHH", "GTA", "HET", "OMH", "PDN", "PEG"]
		
	# Given a date range, grab and sort all the markets
	def gather_markets
		markets = Market.find(:all, :conditions => { :for_date => start_date..end_date })
		@sorted_markets = {}
		
		# Collect markets by name
		markets.each do |m|
			if @sorted_markets[m.name] == nil
				@sorted_markets[m.name] = {}
				SUPPLY_HOSTS[1..-1].each do |host|
					@sorted_markets[m.name][host] = [0.0, 0.0]
				end
			end
			
			@sorted_markets[m.name][m.supply_host][0] += m.col_1.to_f
			@sorted_markets[m.name][m.supply_host][1] += m.col_2.to_f
		end
		@sorted_markets
	end
	
	
	def to_js(kind)
		kind = kind.to_sym
		logger.info "Kind: #{kind}"
		js_string = get_header(kind)
		logger.info "Header: #{js_string}"
		@sorted_markets.each do |market_name, supply_hosts|
			js_string << "[\"#{market_name}\", "
			SUPPLY_HOSTS[1..-1].each do |host|
				case kind
				when :all
					js_string << "#{supply_hosts[host][0]},"
					js_string << "#{supply_hosts[host][1]},"
				when :burst
					js_string << "#{supply_hosts[host][0]},"
				when :cache
					js_string << "#{supply_hosts[host][1]},"
				end
			end
			js_string[-1] = ""
			js_string << "],"
		end
		js_string[-1] = ""
		js_string << "];"
	end
	
	private #--------------------
	
	def get_header(kind)
		case kind
		when :all
			hdr = "[[\"Market\", "
			hdr << SUPPLY_HOSTS[1..-1].map { |name| "\"#{name} (burst)\", \"#{name} (cache)\", " }.to_s
			hdr[-1] = ""
			hdr << "], "
		else
			return "[[\"#{SUPPLY_HOSTS.join("\", \"")}\"], "
		end
	end
		
		## Sum values
		#summed_markets = {}
		#sorted_markets.each do |market_name, market_obj|
		#	#summed_markets[market_name] = {} if summed_markets[market_name].blank?
		#	summed_markets[market_name] ||= {}
		#	mkt = summed_markets[market_name]
		#	mkt["1V"] = sorted_markets.sum { |m| m.col_1}
		#end
	
	#def add market
	#  if @markets == nil
	#	@markets = []
	#end
	#  @markets << market
	#end

	#def to_js
	#	remapped = remap
    #
	#	final_mapping = {}
	#	remapped.each do |market_name, market_obj|
	#	  final_mapping[market_name] = {}
	#	  final_mapping[market_name]["1V"] = []
	#	  final_mapping[market_name]["ALL"] = []
	#	  final_mapping[market_name]["DCHH"] = []
	#	  final_mapping[market_name]["GTA"] = []
	#	  final_mapping[market_name]["HET"] = []
	#	  final_mapping[market_name]["OMH"] = []
	#	  final_mapping[market_name]["PDN"] = []
	#	  final_mapping[market_name]["PEG"] = []
	#	end
    #
    #
	#	remapped.each do |market_name, market_obj|
	#	  market_obj.each do |host_name, market_obj2|
	#	    final_mapping[market_name][host_name] << market_obj2.col_1
	#	    final_mapping[market_name][host_name] << market_obj2.col_2
	#	    final_mapping[market_name][host_name] << market_obj2.total
	#	  end
	#	end
    #
    #
	#	js_string = ""
    #
	#	js_string << "[[\"#{SUPPLY_HOSTS.join("\", \"")}\"], "
	#	final_mapping.each do |market_name, host_name|
	#	  line  = "[\"#{market_name}\", "
	#	  host_name.each do |key, val|
	#	    if val[0] == "N/A"
	#	      val[0] = "0.0"
	#	    end
	#	    line += "#{val[0] ||= 0.0}, "
	#    
	#	    if val[1] == "N/A"
	#	      val[1] = "0.0"
	#	    end
	#	    line += "#{val[1] ||= 0.0}, "
	#	    #line += "#{val[2]}\t"
	#	  end
	#	  js_string << "#{line[0..-3]}],"
	#	end
	#	js_string[-1] = ""
	#	js_string << "];"
	#	
	#end


	#private #---------------------
    #
	#def remap
	#  remapped = {}
	#  @markets.each do |m|
	#    if remapped[m.name] == nil
	#      remapped[m.name] = {}
	#    end
	#    remapped[m.name][m.supply_host] = m
	#  end
	#  remapped
	#end	
	
end
