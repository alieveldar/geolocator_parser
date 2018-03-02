require 'net/http'
require 'json'
require 'pp'

def find_hash(hash)
  json_hash = hash
  json_hash.each do |line|
    puts line
    line = line
    if line.length != 0
      find_hash(line)
  end


  end
  end
uri = URI('https://geocode-maps.yandex.ru/1.x/?')
params = { :format => "json", :geocode => "Москва,+улица+Новый+Арбат,+дом 24"}
points = []
zip = []
count_lines = 0
filein = File.new("./kzn.csv")
fileout = File.new("./togeo.csv", 'w')
  filein.each do |line|
    count_lines = count_lines + 1
    points << line.split(";")

  fileout.print(line)
  end
  puts points
  puts points.length
  puts count_lines
 filein.close
fileout.close
uri.query = URI.encode_www_form(params)
res = Net::HTTP.get_response(uri)
if res.is_a?(Net::HTTPSuccess)
  point_json = res.body
  point_json = JSON.parse(point_json)
  puts point_json["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["Point"]["pos"]


end

