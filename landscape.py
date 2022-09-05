#!/usr/bin/env python

import sys
from PIL import Image, ImageOps

from lib import bands, apply_bands

img = Image.open(sys.argv[1])
img = ImageOps.grayscale(img)
target_size = 160
scale = target_size / max(img.size)
img = img.resize((int(img.size[0] * scale), int(img.size[1] * scale)))

# background isn't uniformly black
histogram = img.histogram()
histogram[0:3] = [0, 0, sum(histogram[0:3])]

img_bands = bands(histogram, levels=4)
img_bands_apply = apply_bands(img_bands)

pixels = img.load()
for i in range(img.size[0]):
    for j in range(img.size[1]):
        pixels[i, j] = img_bands_apply(pixels[i, j])

img.save(sys.argv[2])
