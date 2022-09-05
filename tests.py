from lib import apply_bands, bands

def test_bands_with_dark_background():
    histogram = [100] * 3 + [1] * 9
    assert bands(histogram, smooth=3, levels=2) == [3]

def test_bands_multiple_levels():
    histogram = [10, 0, 0, 1, 1, 1, 1, 1, 1, 5, 5]
    assert bands(histogram, levels=3) == [1, 10]

def test_apply_bands():
    bands = [10, 50, 100, 200]
    fn = apply_bands(bands)
    assert fn(0) == 0
    assert fn(10) == 63
    assert fn(20) == 63
    assert fn(60) == 127
    assert fn(120) == 191
    assert fn(220) == 255
    assert fn(255) == 255
