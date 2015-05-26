# -*- coding: utf-8 -*-
require 'find'

JPEG_EXT = '.jpg'
PNG_EXT = '.png'

raise "### The format of argument is not correct. The number should be 1." unless ARGV.size == 1

def update_image_names(file_name)
  File.readlines(file_name).each do |category_name|
    category_name.chomp!

    if !(File.directory?(category_name))
      puts "### No directory exist : " + category_name
      return
    end

    file_name = category_name + '/' + category_name + '.txt' 
    file = open(file_name, "w") 

    Find.find(category_name) do |image_name|
      if !isImageFile(image_name)
        puts "### No image file exist : " + image_name
      else
        puts "### Write : " + image_name
        file.puts image_name 
      end
    end
  end
end

def isImageFile(file_name)
  extname = File.extname(file_name)
  return false if extname != JPEG_EXT && extname != PNG_EXT
  return true
end

update_image_names(ARGV[0])
