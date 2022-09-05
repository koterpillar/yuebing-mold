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
