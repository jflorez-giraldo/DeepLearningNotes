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
      def strip_front_matter:
        if .[0] == "---\n" then
          (.[1:] | index("---\n")) as $end
          | if $end == null then . else .[($end + 2):] end
          | if .[0] == "\n" then .[1:] else . end
        else . end;

      .cells |= map(
        if .cell_type == "markdown" then
          .source |= (
            map(select(test("^\\{\\{< chapter-actions >\\}\\}\\s*$") | not))
            | strip_front_matter
          )
        else . end
      )
      | del(.metadata.kernelspec.path)
    ' "$notebook" > "$cleaned_notebook"
    mv "$cleaned_notebook" "$notebook"
  fi
done

echo "Notebooks generated in $PROJECT_DIR/notebooks"
