# -*- coding: utf-8 -*-
#グーグル画像検索から画像をダウンロードする
#使い方
# ruby google_images.rb word1 word2 ...
#  word1,word2は検索ワード
#  wordを省略した場合、words.txtを読み込んで検索ワードとする
#     words.txtはUTF-8の改行区切りで
# $KCODE='UTF8'
require 'cgi'
require 'open-uri'
require 'kconv'
require 'json'

PAGES = 5
STEP = 20
AGENT = 'Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.7.5) Gecko/20041108 Firefox/1.0'

# urlの画像をnameとして保存
def save_image(url, name)
  # wは新規作成書き込みモード bはバイナリモード
  open(name, 'wb') do |image|
    open(url) do |data|
      image.write(data.read)
    end
  end
end

if ARGV.size > 0                # 実行時入力があった場合
  words = ARGV.dup
else                            # 実行時入力がない場合
  words = []
  File.readlines('words.txt').each do |l|
    word = l.gsub(/\n/, '').gsub(/\r/, '').strip
    words << word unless word.empty?
  end
end

words.each do |word|
  # エスケープ処理
  w = CGI.escape(word)
  url = "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{w}&rsz=large"
  # URLを開く
  f = open(url, {"User=Agetn" => AGENT}).read
  data = JSON.parse(f)
  results = data['responseData']['results']
  (0..10).each do |i|
    url = results[i]['url']
    puts word
    if url
      #漢字コードを変換
      dir_name = word.tosjis
      # ディレクトリがなければ生成
      Dir.mkdir(dir_name) unless File.exist?(dir_name)

      #画像URLを格納
      #       dyn.first.scan(/http:\/\/(.*?)"/).each do |img_url|
      # 順にURLをを配列に格納
      #      urls << ('http://' + img_url.first)
      #     end
      #    if u = urls[1]
      puts "the url is " + url
      folder = dir_name
      extension = '.jpg'

      #ファイル名置き換え
      new_filename = folder + '/' + dir_name + i.to_s + extension
      puts new_filename
      begin
        save_image(url, new_filename)
      rescue
      rescue OpenURI::HTTPError
      rescue Net::HTTPBadResponse
      rescue Errno::ECONNREFUSED
      rescue Errno::ECONNRESET
      rescue Errno::EBADF
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
