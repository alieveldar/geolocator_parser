require 'net/http'
require 'json'
require 'pp'

uri = URI('https://geocode-maps.yandex.ru/1.x/?')
params = { :format => "json", :geocode => "Москва,+улица+Новый+Арбат,+дом 24"}
points_address = []
points_position = []
zip = []
count_lines = 0
filein = File.new("./kzn.csv")
fileout = File.new("./togeo.csv", 'w')
  filein.each do |line|
    points_address << line.split(";")
    params = {:format => "json", :geocode => points_address[0][0].to_s}
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      point_json = res.body
      point_json = JSON.parse(point_json)
      points_position << point_json["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["Point"]["pos"].split(" ")
    fileout.print(points_position[0][0].to_s + ";" + points_position[0][1].to_s + ";" + points_address[0].to_s + ";" + points_address[0][0].to_s)
      sleep(1)
  end
filein.close
fileout.close




  puts points_address[0][0]
  puts points_position[0][1]


end

