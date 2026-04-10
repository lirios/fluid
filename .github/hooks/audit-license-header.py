#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: MPL-2.0
"""
PostToolUse hook: verify that MPL-2.0 SPDX headers are still present after
replace_string_in_file edits .cpp/.h/.qml files.

Reads the Copilot agent tool-use event from stdin (JSON), reads the modified
file from disk with `cat`, and returns a block decision when the header has
been stripped or corrupted by the edit.
"""
import json
import os
import subprocess
import sys

GUARDED_EXTENSIONS = ('.cpp', '.h', '.qml')
HEADER_SEARCH_LINES = 10


def _has_spdx_header(content: str) -> bool:
    lines = content.splitlines()[:HEADER_SEARCH_LINES]
    has_copyright = any('SPDX-FileCopyrightText:' in line for line in lines)
    has_license   = any('SPDX-License-Identifier: MPL-2.0' in line for line in lines)
    return has_copyright and has_license


def _read_file(path: str) -> str | None:
    """Return file contents, or None when the file cannot be read."""
    try:
        result = subprocess.run(
            ['cat', '--', path],
            capture_output=True,
            text=True,
            timeout=5,
        )
        if result.returncode == 0:
            return result.stdout
    except (OSError, subprocess.TimeoutExpired):
        pass
    return None


def _block(path: str) -> None:
    reason = (
        f"SPDX license header was removed or corrupted in '{path}' by the edit.\n"
        "Restore the following two lines at the very top of the file:\n\n"
        "  // SPDX-FileCopyrightText: <year> <Author Name> <email@example.com>\n"
        "  // SPDX-License-Identifier: MPL-2.0\n\n"
        "See .github/copilot-instructions.md for the full license header policy."
    )
    output = {
        "decision": "block",
        "reason": reason,
    }
    sys.stdout.write(json.dumps(output))
    sys.exit(0)


def main() -> None:
    try:
        event: dict = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        sys.exit(0)

    tool_name: str   = event.get('tool_name', '')
    tool_input: dict = event.get('tool_input', {})

    if tool_name != 'replace_string_in_file':
        sys.exit(0)

    file_path: str = tool_input.get('filePath', '')

    if not file_path.endswith(GUARDED_EXTENSIONS):
        sys.exit(0)

    if not os.path.isfile(file_path):
        # File was deleted or path is wrong — not our concern here.
        sys.exit(0)

    content = _read_file(file_path)
    if content is None:
        # Cannot read; let it pass rather than block legitimate work.
        sys.exit(0)

    if not _has_spdx_header(content):
        _block(file_path)

    sys.exit(0)


if __name__ == '__main__':
    main()
