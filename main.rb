require 'net/http'
require 'json'
require 'pp'

def getLocation(address)
  points_position = []
  geo_coder_csv_row = []
  points_address = address
  uri = URI('https://geocode-maps.yandex.ru/1.x/?')
  params = {:format => "json", :geocode => points_address[0][0]}
  uri.query = URI.encode_www_form(params)
  res = Net::HTTP.get_response(uri)
  puts res

  if res.is_a?(Net::HTTPSuccess)
    point_json = res.body
    point_json = JSON.parse(point_json)
    points_position << point_json["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["Point"]["pos"].split(" ")
    geo_coder_csv_row << (points_position[0][1].to_s + ";" + points_position[0][0].to_s + ";" + points_address[0][1].to_s.chomp! + ";" + points_address[0][0].to_s)
    print geo_coder_csv_row
  else
    puts "SOME NO GOOD"
  end
  return geo_coder_csv_row
end
geo_code_csv = []
points_address = []
filein = File.new("./kzn.csv")
fileout = File.new("./togeo.csv", 'w')
filein.each do |line|
    points_address << line.split(";")
    geo_code_csv << getLocation(points_address)
    points_address.clear
    sleep 0.5
end
filein.close

geo_code_csv.each do |row|
  row.flatten!

  fileout.puts(row)
end
fileout.close


