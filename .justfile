# list all available recipes
[private]
default:
  @just --list --unsorted

# update thumbnail
png:
  @typst c -f png --pages 1 --root . template/thesis.typ thumbnail.png

# build pdf
pdf:
  @typst c --root . template/thesis.typ

# export profile
json:
  @typst c --root . template/thesis.typ --timings record.json
