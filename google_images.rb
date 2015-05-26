# -*- coding: utf-8 -*-
require 'cgi'
require 'open-uri'
require 'kconv'
require 'json'

PAGES = 5
STEP = 20
NUM_IMAGES = 40
GOOGLE_RESTRICT = 8
AGENT = 'Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.7.5) Gecko/20041108 Firefox/1.0'

def save_image(url, name)
  open(name, 'wb') do |image|
    open(url) do |data|
      image.write(data.read)
    end
  end
end

if ARGV.size > 0
  words = ARGV.dup
else 
  words = []
  File.readlines('words.txt').each do |l|
    word = l.gsub(/\n/, '').gsub(/\r/, '').strip
    words << word unless word.empty?
  end
end

words.each do |word|
  w = CGI.escape(word)

  num_fetch_iterate = (NUM_IMAGES / GOOGLE_RESTRICT).truncate

  (0..num_fetch_iterate).each do |iterate_num|
    start_num = GOOGLE_RESTRICT * iterate_num
    puts "Google start number : " + start_num.to_s

    url = "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{w}&rsz=large&start=#{start_num}"
    f = open(url, {"User=Agetn" => AGENT}).read
    data = JSON.parse(f)
    results = data['responseData']['results']

    (0..GOOGLE_RESTRICT - 1).each do |index_current|
      index_sum = GOOGLE_RESTRICT * iterate_num + index_current
      break if index_sum == NUM_IMAGES

      url = results[index_current]['url']
      puts "---"
      puts word

      if url
        dir_name = word.tosjis
        Dir.mkdir(dir_name) unless File.exist?(dir_name)

        puts "URL: " + url
        folder = dir_name
        extension = '.jpg'

        new_filename = folder + '/' + dir_name + index_sum.to_s + extension
        puts new_filename
        begin
          save_image(url, new_filename)
        rescue
        rescue OpenURI::HTTPError
        rescue Net::HTTPBadResponse
        rescue Errno::ECONNREFUSED
        rescue Errno::ETIMEDOUT
        rescue Errno::EHOSTUNREACH
        rescue Timeout::Error
        rescue EOFError
        rescue SocketError
          puts "error:#{u}"
        end
      end
    end
  end
end
