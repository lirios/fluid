#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: MPL-2.0
"""
PostToolUse hook: verify that MPL-2.0 SPDX headers are still present after
apply_patch edits a .cpp/.h/.qml file.

Scans every "*** Update File: <path>" block in the applied patch (honoring
"*** Move to:" renames) and re-checks each guarded file on disk after the
patch has been applied.

Shares its SPDX-checking logic with .claude/hooks/audit-license-header.py
through scripts/hooks/license_header.py.
"""
import os
import re
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'scripts', 'hooks'))
from license_header import check_edited_files, load_event  # noqa: E402

UPDATE_FILE_RE = re.compile(r'^\*\*\* Update File: (.+)$')
MOVE_TO_RE = re.compile(r'^\*\*\* Move to: (.+)$')
MARKER_RE = re.compile(r'^\*\*\* ')


def _iter_updated_files(patch_text: str):
    """Yield the target path for each '*** Update File:' block, honoring renames."""
    lines = patch_text.splitlines()
    i = 0
    while i < len(lines):
        match = UPDATE_FILE_RE.match(lines[i])
        if not match:
            i += 1
            continue
        path = match.group(1).strip()
        i += 1
        if i < len(lines):
            move = MOVE_TO_RE.match(lines[i])
            if move:
                path = move.group(1).strip()
                i += 1
        yield path
        while i < len(lines) and not MARKER_RE.match(lines[i]):
            i += 1


def main() -> None:
    event = load_event()

    tool_name: str   = event.get('tool_name', '')
    tool_input: dict = event.get('tool_input', {})

    if tool_name != 'apply_patch':
        sys.exit(0)

    patch_text: str = tool_input.get('input', '')

    check_edited_files(_iter_updated_files(patch_text))

    sys.exit(0)


if __name__ == '__main__':
    main()
