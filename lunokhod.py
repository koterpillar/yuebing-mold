#!/usr/bin/env python

from PIL import Image, ImageFilter, ImageOps

from lib import map_pixels

img = Image.open("lunokhod.png")
img = ImageOps.grayscale(img)

histogram = img.histogram()
print(histogram)

MAX = 180
LEV = 30

map_pixels(img, lambda x: 255 if x > MAX else x // LEV * LEV)

histogram = img.histogram()
print(histogram)

img = img.filter(ImageFilter.MedianFilter(size=5))

img.save("lunokhod_out.png")
