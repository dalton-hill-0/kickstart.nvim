#!/usr/bin/env python3
"""
Post-processes prettier-formatted markdown to fix checkbox list continuation indent.

Prettier aligns continuation lines with the text start of a list item:
  - [ ] some text   <- "- [ ] " is 6 chars, so continuation gets 6 spaces
        continuation

With conceallevel=2 in neovim, "[ ] " is hidden, so the visual indent is only
2 chars ("- "). This script adjusts continuation lines after checkbox items to
use 2-space indent (matching regular list item continuations) instead of 6.

Works correctly with nested lists by preserving the base nesting indent and
only replacing the checkbox-specific over-indent.
"""

import sys
import re

CHECKBOX_RE = re.compile(r'^(\s*)- \[.\] ')

def fix_checkbox_indent(text: str) -> str:
    lines = text.splitlines(keepends=True)
    out = []
    # Stack of (base_indent, continuation_indent) for open checkbox items
    # base_indent: the spaces before "- " on the checkbox line
    # continuation_indent: what prettier uses (base_indent + 6)
    # desired_indent: what we want (base_indent + 2)
    checkbox_stack: list[tuple[int, int, int]] = []

    for line in lines:
        stripped = line.rstrip('\n')
        m = CHECKBOX_RE.match(stripped)
        if m:
            base = len(m.group(1))
            # Pop any stack entries that are at the same or deeper nesting level
            checkbox_stack = [(b, c, d) for b, c, d in checkbox_stack if b < base]
            cont = base + 6   # prettier's continuation indent for "- [ ] "
            desired = base + 2
            checkbox_stack.append((base, cont, desired))
            out.append(line)
            continue

        # Check if this line is a continuation of a checkbox item
        if stripped and not stripped[0].isspace():
            # Non-indented line closes all checkbox contexts
            checkbox_stack = []
            out.append(line)
            continue

        if checkbox_stack:
            indent = len(stripped) - len(stripped.lstrip())
            # Walk stack from deepest to shallowest
            for base, cont, desired in reversed(checkbox_stack):
                if indent >= cont and stripped.lstrip() != '':
                    # This line is a continuation at this checkbox's level
                    new_line = ' ' * (desired + (indent - cont)) + stripped.lstrip()
                    out.append(new_line + ('\n' if line.endswith('\n') else ''))
                    break
            else:
                # Indent is less than the shallowest checkbox continuation — pop contexts
                checkbox_stack = [(b, c, d) for b, c, d in checkbox_stack if indent > b + 1]
                out.append(line)
        else:
            out.append(line)

    return ''.join(out)


if __name__ == '__main__':
    content = sys.stdin.read()
    sys.stdout.write(fix_checkbox_indent(content))
