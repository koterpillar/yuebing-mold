#!/usr/bin/env python

import sys
from PIL import Image, ImageFilter, ImageOps

from lib import bands, apply_bands

TARGET_SIZE = 400
LEVELS = 6
# background isn't uniformly black
BACKGROUND_THRESHOLD = 2

img = Image.open(sys.argv[1])
img = ImageOps.grayscale(img)

histogram = img.histogram()
histogram[0:BACKGROUND_THRESHOLD + 1] = [0] * BACKGROUND_THRESHOLD + [sum(histogram[0:BACKGROUND_THRESHOLD + 1])]

img_bands = bands(histogram, levels=LEVELS)
img_bands_apply = apply_bands(img_bands)

pixels = img.load()
for i in range(img.size[0]):
    for j in range(img.size[1]):
        pixel = pixels[i, j]
        if pixel <= BACKGROUND_THRESHOLD:
            pixel = 255
        else:
            pixel = img_bands_apply(pixel)
        pixels[i, j] = pixel

img = img.filter(ImageFilter.MedianFilter(size=5))

scale = TARGET_SIZE / max(img.size)
img = img.resize((int(img.size[0] * scale), int(img.size[1] * scale)))

img = img.filter(ImageFilter.MedianFilter(size=5))

img.save(sys.argv[2])
