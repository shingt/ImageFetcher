# GoogleImageFetcher

Download images using google image search engine.

## Usage

word1, word2, ... are words you want to search.  
If argument is omitted words.txt in the same directory is imported.

```sh
ruby google_images.rb word1 word2 ...
```

### update_image_names.rb

Read foo.txt as an argument and create CategoryName.txt.  
If you put

```sh
ruby update_image_names.rb train_data_file_names.txt
```

and if that text file contains

```sh
apples
faces
animals
```

then

```sh
apples/apples.txt
faces/faces/txt
animals/animals.txt
```

will be created.  
Each file has the names of images under each category. For instance, apples.txt will contain

```sh
apple/apple1.jpg
apple/apple2.jpg
apple/apple333.png
```

Note image file name comes from the original images under `apples/` directory in this case.

