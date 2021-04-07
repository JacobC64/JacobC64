#!/usr/bin/ruby
require "uri"
require "net/http"
require 'json'

#gets initiall access token
url = URI("https://api.tdameritrade.com/v1/oauth2/token")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Post.new(url)
request["Content-Type"] = "application/x-www-form-urlencoded"
request.body = "grant_type=refresh_token&refresh_token=78y1tQD3Gm%2F9Ho2kpXKb0PwPKUfWsA2nHyN5oHJmFCEltUtM0UxKNTUkn11b%2FGAmlXLkDy8mJD4bal%2Fcg0iyVjxptbyHSM1jgoJkEMgC8aMayoQifYcd2lFa8wQMWZ0%2F9VEVxln%2Fq2IuLWA75ngqBj7K7K5niKWWuyGR5j7UR5lUKJLLrNQ1VLcQLXIBOvichqiqczUlZcDd1qUW8Tk9jCPYxic8GFxddV5Wg01J9aFHKbykPto%2FgJMhvCBi8qhrH3Xb64lh6ScaQFiAzCjXkXojwSDsAPN2MuzQ4xFVlX3amVtXfCMZlEN2UqrXre7gufUHtVtiIV8UIGk1R94lpuZniskCYFrr%2Fq5GEBVkJcuYjn19pTAJx5hvgH9kapiH3eBiioFcag8n9KTblybnhoRTax9etniVqn80rsCqSVf9drg32%2Fhx4EjQFbz100MQuG4LYrgoVi%2FJHHvl5N31xivZ2WhnZUMmWHPr%2FX7FB1wRwtz%2FmdwI8FFSl2yI7vhnkb7ikV9Yu7tbRLwWm9e5%2FyrXUCdiEGWiJRN2EL32Y4b1uTyhPQdHIyF3cPbt2728sxr%2FWjIMNSGvIvInVr14pGhB1Su9SXo4jO1CM1iVZMBCOcKGrKz92n6PLMEFFGrtNOk1lA69SiUUwTHg%2B4f0T4dVC8ahWrytCOrHAUiDOtF6WRIzHv7SRngN6xeNLVw0axk%2BrsMby98oyxlsD1K5RRma3f7iuZEtU9%2FdNp%2FFEZEfDxeuSO4X%2F1nEh4L%2BNFDDAuDysQsQQxetSqmFthBC0yBTIvzdXG8pD0iiXIqDjt91Vp5ts163ckr0zI9Lgz8%2BsgMp0o8ygdFHuGe13H8nGqZE1fKgOuzXt7SWNNFEhoAXxyiyVr9Wea%2Fc9X4DHKcZxuwAmpZdbjU%3D212FD3x19z9sWBHDJACbC00B75E&access_type=&code=&client_id=GJ1DP6LYGCSF9QRKG7N2ERUYVLWHCGAO&redirect_uri=http%3A%2F%2Flocalhost"

response = https.request(request)
puts response.body
data = JSON.parse(response.body)
$accessToken = data["access_token"]
mins = 0
isBuy = true
isSell = true
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
        request.body = "grant_type=refresh_token&refresh_token=78y1tQD3Gm%2F9Ho2kpXKb0PwPKUfWsA2nHyN5oHJmFCEltUtM0UxKNTUkn11b%2FGAmlXLkDy8mJD4bal%2Fcg0iyVjxptbyHSM1jgoJkEMgC8aMayoQifYcd2lFa8wQMWZ0%2F9VEVxln%2Fq2IuLWA75ngqBj7K7K5niKWWuyGR5j7UR5lUKJLLrNQ1VLcQLXIBOvichqiqczUlZcDd1qUW8Tk9jCPYxic8GFxddV5Wg01J9aFHKbykPto%2FgJMhvCBi8qhrH3Xb64lh6ScaQFiAzCjXkXojwSDsAPN2MuzQ4xFVlX3amVtXfCMZlEN2UqrXre7gufUHtVtiIV8UIGk1R94lpuZniskCYFrr%2Fq5GEBVkJcuYjn19pTAJx5hvgH9kapiH3eBiioFcag8n9KTblybnhoRTax9etniVqn80rsCqSVf9drg32%2Fhx4EjQFbz100MQuG4LYrgoVi%2FJHHvl5N31xivZ2WhnZUMmWHPr%2FX7FB1wRwtz%2FmdwI8FFSl2yI7vhnkb7ikV9Yu7tbRLwWm9e5%2FyrXUCdiEGWiJRN2EL32Y4b1uTyhPQdHIyF3cPbt2728sxr%2FWjIMNSGvIvInVr14pGhB1Su9SXo4jO1CM1iVZMBCOcKGrKz92n6PLMEFFGrtNOk1lA69SiUUwTHg%2B4f0T4dVC8ahWrytCOrHAUiDOtF6WRIzHv7SRngN6xeNLVw0axk%2BrsMby98oyxlsD1K5RRma3f7iuZEtU9%2FdNp%2FFEZEfDxeuSO4X%2F1nEh4L%2BNFDDAuDysQsQQxetSqmFthBC0yBTIvzdXG8pD0iiXIqDjt91Vp5ts163ckr0zI9Lgz8%2BsgMp0o8ygdFHuGe13H8nGqZE1fKgOuzXt7SWNNFEhoAXxyiyVr9Wea%2Fc9X4DHKcZxuwAmpZdbjU%3D212FD3x19z9sWBHDJACbC00B75E&access_type=&code=&client_id=GJ1DP6LYGCSF9QRKG7N2ERUYVLWHCGAO&redirect_uri=http%3A%2F%2Flocalhost"
        
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
    if (isBuy == true && $markChang <= -1.0 || $markChang >= 0.5)
        url = URI("https://api.tdameritrade.com/v1/accounts/237054069/orders")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["Authorization"] = "Bearer " + $accessToken
        request["Content-Type"] = "application/json"
        request.body = "{\r\n  \"orderType\": \"MARKET\",\r\n  \"session\": \"NORMAL\",\r\n  \"duration\": \"DAY\",\r\n  \"orderStrategyType\": \"SINGLE\",\r\n  \"orderLegCollection\": [\r\n    {\r\n      \"instruction\": \"Buy\",\r\n      \"quantity\": 1,\r\n      \"instrument\": {\r\n        \"symbol\": \"GE\",\r\n        \"assetType\": \"EQUITY\"\r\n      }\r\n    }\r\n  ]\r\n}"

        response = https.request(request)
        puts "buy"
        puts response.read_body
        isBuy = false
        isSell = true
        
        
    end
    #checks if in sell state
    #sells if price is high enough
    if (isSell == true && $markChang >= 1.0)
        url = URI("https://api.tdameritrade.com/v1/accounts/237054069/orders")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        
        request = Net::HTTP::Get.new(url)
        request["Authorization"] = "Bearer " + $accessToken
        request["Content-Type"] = "text/plain"
        request.body = "{\r\n  \"orderType\": \"MARKET\",\r\n  \"session\": \"NORMAL\",\r\n  \"duration\": \"DAY\",\r\n  \"orderStrategyType\": \"SINGLE\",\r\n  \"orderLegCollection\": [\r\n    {\r\n      \"instruction\": \"SELL\",\r\n      \"quantity\": 1,\r\n      \"instrument\": {\r\n        \"symbol\": \"GE\",\r\n        \"assetType\": \"EQUITY\"\r\n      }\r\n    }\r\n  ]\r\n}"
        
        response = https.request(request)
        isSell = false
        isBuy = true
        puts "sell"
        puts response.read_body
        
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
