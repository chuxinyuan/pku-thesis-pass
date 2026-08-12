#!/usr/bin/env bash
set -euo pipefail

typst compile tests/unit/number-test.typ --root .
typst compile tests/unit/util-test.typ --root .
typst compile tests/unit/cli-test.typ --root .
typst compile tests/unit/resolve-test.typ --root .
typst compile tests/unit/counter-test.typ --root .
typst compile tests/unit/supplement-test.typ --root .
typst compile tests/unit/wordcount-test.typ --root .
