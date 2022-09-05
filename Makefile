.PHONY: lunokhod.png

lunokhod.png:
	curl -sSL -o lunokhod.png --etag-compare lunokhod.png.etag --etag-save lunokhod.png.etag https://cs11.pikabu.ru/post_img/big/2019/11/17/5/1573975607121742309.png

lunokhod_out.png: lunokhod.png lunokhod.py
	poetry run ./lunokhod.py

lunokhod.stl: mold.scad lunokhod_out.png
	openscad -o lunokhod.stl mold.scad
