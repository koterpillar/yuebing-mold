from PIL import Image
from typing import Callable


Bands = list[int]

def bands(histogram: list[int], *, smooth: int = 1, levels: int) -> Bands:
    total = sum(histogram)
    threshold = total / levels

    result = []

    idx = 0
    in_band = 0
    while True:
        idx_next = idx + smooth
        if idx_next >= len(histogram):
            break
        in_band += sum(histogram[idx: idx_next])
        if in_band >= threshold:
            result.append(idx_next)
            in_band = 0
        idx = idx_next

    return result


def apply_bands(bands: Bands, *, maximum: int = 255) -> Callable[[int], int]:
    mapping = {}
    idx = 0
    for val in range(maximum + 1):
        if idx < len(bands) and val == bands[idx]:
            idx += 1
        mapping[val] = idx * maximum // len(bands)
    return mapping.__getitem__


def map_pixels_coord(image: Image, fn: Callable[[int, int, int], int]) -> None:
    pixels = image.load()
    for i in range(image.size[0]):
        for j in range(image.size[1]):
            pixels[i, j] = fn(pixels[i, j], i, j)


def map_pixels(image: Image, fn: Callable[[int], int]) -> None:
    return map_pixels_coord(image, lambda v, x, y: fn(v))
