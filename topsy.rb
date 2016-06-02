require 'httparty'

response = HTTParty.get('http://google.com')
json = JSON.parse(response.body)
puts json