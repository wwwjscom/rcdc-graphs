class Markets
  def initialize
    @markets = []
  end

  def << market
    @markets << market
  end

  def remap
    remapped = {}
    @markets.each do |m|
      if remapped[m.name] == nil
        remapped[m.name] = {}
      end
      remapped[m.name][m.host] = m
    end
    remapped
  end
end

class Market
  attr_accessor :name, :host, :col1, :col2, :total

  def initialize(line)
    line = line.chomp.split("\t")
    self.name = line[0] 
    self.host = line[1]
    self.col1 = line[2]
    self.col2 = line[3]
    self.total = line[4]
  end
end


f = File.open("/Users/wwwjscom/Desktop/market-data.txt")

markets = Markets.new
while line = f.gets do
  market = Market.new(line)
  markets << market
end

remapped = markets.remap

final_mapping = {}
remapped.each do |market_name, market_obj|
  final_mapping[market_name] = {}
  final_mapping[market_name]["1V"] = []
  final_mapping[market_name]["ALL"] = []
  final_mapping[market_name]["DCHH"] = []
  final_mapping[market_name]["GTA"] = []
  final_mapping[market_name]["HET"] = []
  final_mapping[market_name]["OMH"] = []
  final_mapping[market_name]["PDN"] = []
  final_mapping[market_name]["PEG"] = []
end


remapped.each do |market_name, market_obj|
  market_obj.each do |host_name, market_obj2|
    final_mapping[market_name][host_name] << market_obj2.col1
    final_mapping[market_name][host_name] << market_obj2.col2
    final_mapping[market_name][host_name] << market_obj2.total
  end
end

HEADER = ["Market", "1V", "ALL", "DCHH", "GTA", "HET", "OMH", "PDN", "PEG"]
puts "[[\"#{HEADER.join("\", \"")}\"], "
final_mapping.each do |market_name, host_name|
  line  = "[\"#{market_name}\", "
  host_name.each do |key, val|
    if val[0] == "N/A"
      val[0] = "0.0"
    end
    line += "#{val[0] ||= 0.0}, "

    if val[1] == "N/A"
      val[1] = "0.0"
    end
    line += "#{val[1] ||= 0.0}, "
    #line += "#{val[2]}\t"
  end
  puts "#{line[0..-3]}],"
end
puts "];"
