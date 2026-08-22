#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$PROJECT_DIR/notebooks"

for chapter in "$PROJECT_DIR"/chapters/chapter*.qmd; do
  name="$(basename "${chapter%.qmd}")"
  notebook="$PROJECT_DIR/notebooks/$name.ipynb"
  quarto convert "$chapter" --output "$notebook"

  if command -v jq >/dev/null 2>&1; then
    cleaned_notebook="$(mktemp)"
    jq '
      .cells |= map(
        if .cell_type == "markdown" then
          .source |= (
            map(select(test("^\\{\\{< chapter-actions >\\}\\}\\s*$") | not))
            | if .[0] == "---\n" then .[4:] else . end
          )
        else . end
      )
      | del(.metadata.kernelspec.path)
    ' "$notebook" > "$cleaned_notebook"
    mv "$cleaned_notebook" "$notebook"
  fi
done

echo "Notebooks generated in $PROJECT_DIR/notebooks"
