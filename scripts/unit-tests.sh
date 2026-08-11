#!/usr/bin/env bash
set -euo pipefail

typst compile tests/number-test.typ --root .
typst compile tests/util-test.typ --root .
typst compile tests/style-test.typ --root .
typst compile tests/cli-test.typ --root .
typst compile tests/size-test.typ --root .
typst compile tests/font-test.typ --root .
typst compile tests/component-test.typ --root .
typst compile tests/resolve-test.typ --root .
typst compile tests/counter-test.typ --root .
typst compile tests/supplement-test.typ --root .
typst compile tests/wordcount-test.typ --root .
