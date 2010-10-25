class Market < ActiveRecord::Base
	
	def parse(line)
	  line = line.chomp.split("\t")
	  self.name = line[0] 
	  self.supply_host = line[1]
	  self.col_1 = line[2]
	  self.col_2 = line[3]
	  self.total = line[4]
	end
	
end
