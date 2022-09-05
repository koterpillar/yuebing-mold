#!/usr/bin/env python

from PIL import Image, ImageFilter, ImageOps

from lib import map_pixels, map_pixels_coord

img = Image.open("lunokhod.png")
img = ImageOps.grayscale(img)

MAX = 180
LEV = 30

map_pixels(img, lambda x: 255 if x > MAX else x // LEV * LEV)

map_pixels_coord(img, lambda v, x, y: v if y > x * 0.3 + 350 else 255)

img = img.filter(ImageFilter.MedianFilter(size=5))

img = img.rotate(-14)
img = img.crop((50, 350, 630, 950))

img.save("lunokhod_out.png")
