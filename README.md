# GoogleImageFetcher

Just download images using google image search engine.

## Usage


```sh
# If word argument is omitted, words.txt in the same directory is used instead.
ruby google_images.rb word1 word2 ...
```

### update_image_names.rb

```sh
ruby update_image_names.rb file_names.txt
```

and if `file_names.txt` contains

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

will be generated.
Each file contains names of images for each category.
For instance, `apples.txt` will contain

```sh
apple/apple1.jpg
apple/apple2.jpg
apple/apple333.png
```

Note image file name comes from the original images under `apples/` directory in this case.

