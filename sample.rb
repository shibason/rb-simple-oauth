#!/usr/bin/env ruby
# coding: utf-8

require 'simple-oauth'
require 'rubygems'
require 'json'

CONSUMER_KEY = 'MLGBSz9H4UzJSOIr50tj9w'
CONSUMER_SECRET = '8rceHBJvxj2UW6v5lxkDgEXjfUBWA356F3HDcUWGM'
TOKEN = '20833779-91x5vb9gMqIhFNIrqR8I62S30rgrqjECFa4OtE'
TOKEN_SECRET = 'Dp48BD9S2WY2cgzsAJHhIDBlfdkpjzArh4ooBcVBpk'

simple_oauth = SimpleOAuth.new(CONSUMER_KEY, CONSUMER_SECRET, TOKEN, TOKEN_SECRET)

# Tweetの投稿
response = simple_oauth.post('http://twitter.com/statuses/update.json', {
  :status => "こんにちは！この投稿はテストです。 : #{Time.now}"
})
raise "Request failed: #{response.code}" unless response.code.to_i == 200

# TimeLineの取得
response = simple_oauth.get('http://twitter.com/statuses/friends_timeline.json?count=5')
raise "Request failed: #{response.code}" unless response.code.to_i == 200
JSON.parse(response.body).each do |status|
  puts "#{status['user']['screen_name']}: #{status['text']}"
end
