# update_image_names.rb
#
# Get **.txt as an argument and create CategoryName.txt depending on the contents.
#
# e.g. If one implements
#         ruby update_image_names.rb train_data_file_names.txt
#
#      and if the contents of that text file is
#         apples
#         faces
#         animals
#
#     In this case
#         apples/apples.txt
#         faces/faces/txt
#         animals/animals.txt
#
#     will be created.
#     And each file has the names of images under each category.
#     For instance, apples.txt will have 
#
#         apple/apple1.jpg
#         apple/apple2.jpg
#         apple/apple333.png
#
#     Note image file name comes from the original images which are under apples/ 
#     directory in this case.
#

require 'find'

JPEG_EXT = '.jpg'
PNG_EXT = '.png'

raise "### The format of argument is not correct. The number should be 1." unless ARGV.size == 1

def update_image_names(file_name)
  # For each category in that file
  File.readlines(file_name).each do |category_name|
    category_name.chomp!

    if !(File.directory?(category_name))
      puts "### No directory exist : " + category_name
      return
    end

    # Write the name to this category's text file
    file_name = category_name + '/' + category_name + '.txt'   # apples/apples.txt
#    puts "### Write in " + file_name + "!!"
    file = open(file_name, "w")       # New write

    Find.find(category_name) do |image_name|
      if !isImageFile(image_name)
#        puts "### No image file exist : " + image_name
      else
#        puts "### Write : " + image_name
        file.puts image_name       # Write apple/apple1.jpg
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
