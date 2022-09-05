.PHONY: moon.jpg

moon.jpg:
	curl -sSL -o moon.jpg --etag-compare moon.jpg.etag --etag-save moon.jpg.etag https://upload.wikimedia.org/wikipedia/commons/e/e1/FullMoon2010.jpg

moon_levels.jpg: landscape.py moon.jpg
	poetry run ./landscape.py moon.jpg moon_levels.jpg
