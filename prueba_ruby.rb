require 'uri'
require 'net/http'
require 'json'
def request(url, api_key = "caJyYW2hcGTpc0V1IwO6oNqEgrFs9jPjEsyx4xb3")
    url = URI("#{url}&api_key=#{api_key}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["Postman-Token"] = 'caJyYW2hcGTpc0V1IwO6oNqEgrFs9jPjEsyx4xb3'
    response = http.request(request)
    JSON.parse(response.read_body)
end
def build_web_page(data)
  photos = data["photos"].map {|x| x["img_src"]}
  encabezados = "<html>\n<head>\n</head>\n<body>\n<ul>\n"
  html = ""
  photos.each do |x|
    html += "\t<li><img src=\"#{x}\"></li>\n"
  end
  cierre = "</ul>\n</body>\n</html>\n"
  html = "#{encabezados}"+"#{html}"+"#{cierre}"
  File.write('index.html', html)
end
data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")
nasa = build_web_page(data)