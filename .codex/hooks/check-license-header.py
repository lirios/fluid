#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: MPL-2.0
"""
PreToolUse hook: enforce MPL-2.0 SPDX license headers in new .cpp/.h/.qml files.

Codex CLI edits files through a single apply_patch tool whose "input"
argument is a patch that may add, update, or delete several files in one
call (blocks delimited by "*** Add File:" / "*** Update File:" / "***
Delete File:" markers). This hook scans every "*** Add File: <path>" block
and denies the call when a guarded file is being created without the
required SPDX header.

Shares its SPDX-checking logic with .claude/hooks/check-license-header.py
through scripts/hooks/license_header.py.
"""
import os
import re
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'scripts', 'hooks'))
from license_header import check_created_files, load_event  # noqa: E402

ADD_FILE_RE = re.compile(r'^\*\*\* Add File: (.+)$')
MARKER_RE = re.compile(r'^\*\*\* ')


def _iter_added_files(patch_text: str):
    """Yield (path, content) for each '*** Add File:' block in the patch."""
    lines = patch_text.splitlines()
    i = 0
    while i < len(lines):
        match = ADD_FILE_RE.match(lines[i])
        if not match:
            i += 1
            continue
        path = match.group(1).strip()
        i += 1
        body_lines = []
        while i < len(lines) and not MARKER_RE.match(lines[i]):
            if lines[i].startswith('+'):
                body_lines.append(lines[i][1:])
            i += 1
        yield path, '\n'.join(body_lines)


def main() -> None:
    event = load_event()

    tool_name: str   = event.get('tool_name', '')
    tool_input: dict = event.get('tool_input', {})

    if tool_name != 'apply_patch':
        sys.exit(0)

    patch_text: str = tool_input.get('input', '')

    check_created_files(_iter_added_files(patch_text))

    sys.exit(0)


if __name__ == '__main__':
    main()
