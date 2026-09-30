# Preservation tests — M0/M1

First establish an unraised upstream baseline, then import/raise/serialize/read/
lower/export each fixture. Compare required semantic properties, not printed text.
Document normalization of SSA names and attribute numbering; do not normalize
away call ordering, output bytes, branch polarity, or metadata distinctions.

This directory intentionally contains no passing placeholder round-trip test.
