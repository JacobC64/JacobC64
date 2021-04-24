#!/usr/bin/ruby
require "uri"
require "net/http"
require 'json'

#asks for refresh token
puts "Enter your refresh token:"
rToken = gets.chomp

#gets initiall access token
url = URI("https://api.tdameritrade.com/v1/oauth2/token")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Post.new(url)
request["Content-Type"] = "application/x-www-form-urlencoded"
request.body = "grant_type=refresh_token&refresh_token=" + "#{rToken}" + "&access_type=&code=&client_id=GJ1DP6LYGCSF9QRKG7N2ERUYVLWHCGAO&redirect_uri=http%3A%2F%2Flocalhost"

response = https.request(request)
puts response.body
data = JSON.parse(response.body)
$accessToken = data["access_token"]
mins = 0
$isBuy = true
$isSell = true
loop do
    
    currTime = Time.now 

    puts currTime.inspect
    #gets new access token every 30 minutes
    if (mins >= 30)
        url = URI("https://api.tdameritrade.com/v1/oauth2/token")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        
        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = "application/x-www-form-urlencoded"
        request.body = "grant_type=refresh_token&refresh_token=" + "#{rToken}" + "&access_type=&code=&client_id=GJ1DP6LYGCSF9QRKG7N2ERUYVLWHCGAO&redirect_uri=http%3A%2F%2Flocalhost"
        
        response = https.request(request)
        data = JSON.parse(response.body)
        $accessToken = data["access_token"]
        mins = 0
    end

    # gets account details
    url = URI("https://api.tdameritrade.com/v1/accounts/237054069")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer " + $accessToken
    response = https.request(request)
    account = JSON.parse(response.body)
    $accountValue = account["securitiesAccount"]["initialBalances"]["longStockValue"]
    $stockValue = account["securitiesAccount"]["currentBalances"]["longMarketValue"]
    $buyPower = account["securitiesAccount"]["currentBalances"]["cashBalance"]


    #gets quote on specific stock
    url = URI("https://api.tdameritrade.com/v1/marketdata/GE/quotes?")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer " + $accessToken
    
    response = https.request(request)
    puts response.read_body
    quote = JSON.parse(response.body)
    $bidPrice =  quote["GE"]["bidPrice"]
    $markChang =  quote["GE"]["markPercentChangeInDouble"]

    #checks if in buy state
    #buys if price is low enough or is trending up
    if ($isBuy == true && $buyPower >= $bidPrice && ($markChang <= -1.0 || $markChang >= 0.5))
        url = URI("https://api.tdameritrade.com/v1/accounts/237054069/orders")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["Authorization"] = "Bearer " + $accessToken
        request["Content-Type"] = "application/json"
        request.body = "{\r\n  \"orderType\": \"MARKET\",\r\n  \"session\": \"NORMAL\",\r\n  \"duration\": \"DAY\",\r\n  \"orderStrategyType\": \"SINGLE\",\r\n  \"orderLegCollection\": [\r\n    {\r\n      \"instruction\": \"Buy\",\r\n      \"quantity\": 1,\r\n      \"instrument\": {\r\n        \"symbol\": \"GE\",\r\n        \"assetType\": \"EQUITY\"\r\n      }\r\n    }\r\n  ]\r\n}"

        response = https.request(request)
        puts "buy"
        $isBuy = false
        $isSell = true
    end
        
    
    #checks if in sell state
    #sells if price is high enough
    if ($isSell == true && (($stockValue - $accountValue) / $stockValue) > 0.5)
        url = URI("https://api.tdameritrade.com/v1/accounts/237054069/orders")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        
        request = Net::HTTP::Post.new(url)
        request["Authorization"] = "Bearer " + $accessToken
        request["Content-Type"] = "application/json"
        request.body = "{\r\n  \"orderType\": \"MARKET\",\r\n  \"session\": \"NORMAL\",\r\n  \"duration\": \"DAY\",\r\n  \"orderStrategyType\": \"SINGLE\",\r\n  \"orderLegCollection\": [\r\n    {\r\n      \"instruction\": \"Sell\",\r\n      \"quantity\": 1,\r\n      \"instrument\": {\r\n        \"symbol\": \"GE\",\r\n        \"assetType\": \"EQUITY\"\r\n      }\r\n    }\r\n  ]\r\n}"
        puts request.body
        response = https.request(request)

        $isSell = false
        $isBuy = true
        puts "sell"
        
    end
    # runs loop every 60 seconds
    sleep(60)
    mins += 1 
    # runs during market hours
    if (currTime.hour < 10 || currTime.hour >= 16)
        puts "after hours"
        break
    end
end
