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

# run unit tests
test:
  @typst compile tests/number-test.typ --root .
  @typst compile tests/util-test.typ --root .
  @typst compile tests/style-test.typ --root .
  @typst compile tests/cli-test.typ --root .
  @typst compile tests/size-test.typ --root .
  @typst compile tests/font-test.typ --root .

# switch imports to @preview mode (for publishing to Typst Universe)
preview:
  @python3 scripts/release.py preview

# switch imports back to local dev mode
dev:
  @python3 scripts/release.py dev

# bump version references in doc examples to match typst.toml
bump:
  @python3 scripts/bump.py

# collect packaged files into release/<version>/ for Typst Universe submission
publish: test preview bump
  @python3 scripts/publish.py
  @git checkout template/
  @echo "  template/ restored to dev mode"
