#!/usr/bin/env python

import sys
from PIL import Image, ImageFilter, ImageOps

from lib import bands, apply_bands

TARGET_SIZE = 400
LEVELS = 10

img = Image.open(sys.argv[1])
img = ImageOps.grayscale(img)

histogram = img.histogram()
print(histogram)

img_bands = bands(histogram, levels=LEVELS)
img_bands_apply = apply_bands(img_bands)

pixels = img.load()
for i in range(img.size[0]):
    for j in range(img.size[1]):
        pixel = pixels[i, j]
        pixel = img_bands_apply(pixel)
        pixels[i, j] = pixel

img = img.filter(ImageFilter.MedianFilter(size=5))

img.save(sys.argv[2])
