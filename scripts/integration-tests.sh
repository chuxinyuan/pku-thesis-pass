#!/usr/bin/env bash
set -euo pipefail

typst compile tests/thesis-minimal.typ --root .
typst compile tests/thesis-linux.typ --root . --input system=linux
typst compile tests/thesis-full.typ --root .
typst compile tests/thesis-blind.typ --root . --input blind=true
typst compile tests/thesis-heading.typ --root .
typst compile tests/thesis-refs.typ --root .
