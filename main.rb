#!/usr/bin/ruby

require "uri"
require "net/http"

loop do
    currTime = Time.new 
    url = URI("https://api.tdameritrade.com/v1/marketdata/GE/quotes?")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer SNbJcrbY/8p8e0JpmgoP5M12Ev7Qt4Z/Sh1JUE2qAaksFvTTqokLDUX6o312TOYrEbGDFzY8URnJBFxHqxMGcOEEEfjTCv6cDopn97j04fE4NkSp7vr6DOBLbaNICSIH0nsi4X5Yx/up2IYIS9uDLGyWt8zqXxmswytlMd6ghbFRLfzlc28xU8L3KitAgE1yUwCui4wtTZagJIUTCDW/EA7YbwOCJXf3JvpRtCBVMu2y1Nj08TRBL4ZWuhZdKKlmrqU7gVUS/zYeDhcVhxGQYCLPcstdEmQh2nvGXguT8Gb4Q46FW4AITs3+2rzVKOWI/N6ejKlffIo1JlgU0Y757TFSLDNYA/mi+pswJnT/YGHnkm799eEdpcbWmHynuMdpIkC9Wbh2WvzcMexDBQA4rgB2j5c1Cg2ADoMEmi3CeqqOmifaqOXPSD72IPt1buvNF7/iWm4Ps/zoVwO+PRY0MHOiTQ8iOZH0SAcgghkoWhvfzZrw41UYTPE6nqNhzYw5fCmUNiRpsDNKq4vN9Y70MP4GvIR5oKw31n/kX100MQuG4LYrgoVi/JHHvlUsMBhkWa5sJ8DGeiDDkzKYTcrWSO3p+tFIMyOqEzzBd5JJia4eU3pByBUu6am+9n9a5P9u2ELVFwcrQsZbP/VXMlGYcYSQhm/8wXI2GQtrm3vzlplUlyaJNIkuEpuTPT0cKOLHnY8vg0KozER2+6dBLS+M5jG73qJ4jRb8Mk1MWe5P3bPW96vqTR9YG6tMqAV+8IcMv7Qgu/jgK+S7u9N8zOp6HqoDMqYf5KBlJdFzsKeMd3JZFHg10RUtBZMmJ+XlIf7ylHZDi/vJGrHq94Z4nku+OXcyVV39ha0eaWTOJVRUwPCdxrq7bKzkhCx36PRudW6+Rx6fCK4f1Owl/cXrgHnrCpzy61QufTUKFvs64TnL7DfbnkAhK7KBot38On+SeX8olyvLKMLIMVhU1XoAetWYHEqGZ5eGilz6hGSwudYVKBYZ9taCR9cn8YuL2Gf9S8BkXSuNTlWtoFy+HrRqRqYS/MaexSG+jptQYn51n2ukhiQwjLXKObjUodY8A7BbJqSLXb3CNcY5C4jCfhHx65nQcT+m44jdD+DD212FD3x19z9sWBHDJACbC00B75E"
    
    response = https.request(request)
    puts response.read_body
    sleep(60)
    if (currTime.hour < 10 && currTime.hour >= 16)
        break
    end
end
