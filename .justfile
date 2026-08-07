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

# switch imports to @preview mode (for publishing to Typst Universe)
release:
  @python3 scripts/release.py publish

# switch imports back to local dev mode
dev:
  @python3 scripts/release.py dev
