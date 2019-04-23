require 'redis'
require 'sinatra'

set(:bind, '0.0.0.0') # Bind to localhost
SENTINELS = [{ host: ENV['REDIS_HOST'], port: 26379 }]
redis = Redis.new(url: "redis://mymaster", sentinels: SENTINELS, role: :master)

get '/frank-says' do
  'Put this in your pipe & smoke it!'
end

get '/info' do
  redis.info.to_s
end

post '/set/:key/:value' do |key, value|
  redis.set(key, value)
end

get '/get/:key' do |key|
  redis.get(key)
end

post '/bump' do
  key = get_rand_string(10)
  value = File.open("file.txt", "r").read
  redis.set(key, value)
end

def n_rand_values(n)
  values = []
  (1...n).each do
    values << rand
  end
  values
end

def get_rand_string(n)
  (0...n).map { ('a'..'z').to_a[rand(26)] }.join
end

Thread.new do
  string_length = 4
  while true do
    sleep_time = rand(180)
    n = rand(100)
    p "Setting rand=#{n}"
    redis.set('rand', n)

    n_rand_values(n).each do |value|
      redis.set(get_rand_string(string_length), value)
    end

    p "Sleeping for #{sleep_time}"
    sleep(sleep_time)
  end
end
