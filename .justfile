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

# run all tests (unit + integration + spec)
test: unit integration spec

# run unit tests (pure functions)
unit:
  @bash scripts/unit-tests.sh

# run integration tests (end-to-end compilation)
integration:
  @bash scripts/integration-tests.sh

# run format spec tests (white-box style values + black-box PDF check)
spec:
  @bash scripts/spec-tests.sh

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
  @git checkout -- template/
  @echo "  template/ restored to dev mode"
