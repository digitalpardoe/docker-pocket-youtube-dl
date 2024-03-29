#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

youtube_dl_output_template = ENV["YOUTUBE_DL_OUTPUT_TEMPLATE"] || "%(title)s.%(ext)s"
youtube_dl_download_format = ENV["YOUTUBE_DL_DOWNLOAD_FORMAT"] || "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"

puts "Starting pocket-youtube-dl..."
puts "Running as user #{Process.uid} and group #{Process.gid}."

sleep 10

def pocket_request(action, parameters)
  uri = URI.parse("https://getpocket.com/v3/#{action}")

  header = { 'Content-Type': 'application/json' }
  parameters = {
    consumer_key: ENV["POCKET_CONSUMER_KEY"],
    access_token: ENV["POCKET_ACCESS_TOKEN"]
  }.merge(parameters)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = parameters.to_json

  response = http.request(request)

  JSON.parse(response.body)
end

loop do
  puts "Checking for new videos..."

  begin
    video_urls = {}
    urls = video_urls.merge(pocket_request("get", {})["list"].collect { |key,value| [key, value["given_url"]] }.to_h)
    video_urls = urls.select { |key,value|
      value.match(/.*youtube\.com.*/) || value.match(/.*youtu\.be.*/) || value.match(/.*twitch\.com.*/)
    }

    video_urls.each do |key,url|
      result = system("yt-dlp -f #{youtube_dl_download_format} -o '/downloads/#{youtube_dl_output_template}' #{url}")
      if result
        puts "Finished downloading #{url}!"
        pocket_request("send", { actions: [ { action: "archive", item_id: key } ] })
      end
    end
  rescue => e
    puts "Error: #{e}"
  end

  sleep 60
end
