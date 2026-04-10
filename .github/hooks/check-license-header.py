#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: MPL-2.0
"""
PreToolUse hook: enforce MPL-2.0 SPDX license headers in new .cpp/.h/.qml files.

Reads the Copilot agent tool-use event from stdin (JSON), inspects the file
content for the two mandatory SPDX comment lines, and returns a deny decision
when they are absent so the file is never written without a proper header.
"""
import json
import sys

GUARDED_EXTENSIONS = ('.cpp', '.h', '.qml')
HEADER_SEARCH_LINES = 10   # only scan this many lines from the top


def _has_spdx_header(content: str) -> bool:
    """Return True when content contains both required SPDX header lines."""
    lines = content.splitlines()[:HEADER_SEARCH_LINES]
    has_copyright = any('SPDX-FileCopyrightText:' in line for line in lines)
    has_license   = any('SPDX-License-Identifier: MPL-2.0' in line for line in lines)
    return has_copyright and has_license


def _deny(path: str) -> None:
    reason = (
        f"Missing MPL-2.0 SPDX license header in '{path}'.\n"
        "Add the following two lines at the very top of the file:\n\n"
        "  // SPDX-FileCopyrightText: <year> <Author Name> <email@example.com>\n"
        "  // SPDX-License-Identifier: MPL-2.0\n\n"
        "See .github/copilot-instructions.md for the full license header policy."
    )
    output = {
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "deny",
            "permissionDecisionReason": reason,
        }
    }
    sys.stdout.write(json.dumps(output))
    sys.exit(0)


def main() -> None:
    try:
        event: dict = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        # Cannot parse event — let the tool proceed normally.
        sys.exit(0)

    tool_name: str  = event.get('tool_name', '')
    tool_input: dict = event.get('tool_input', {})

    if tool_name == 'create_file':
        file_path: str = tool_input.get('filePath', '')
        content:   str = tool_input.get('content', '')

        if not file_path.endswith(GUARDED_EXTENSIONS):
            sys.exit(0)

        if not _has_spdx_header(content):
            _deny(file_path)

    sys.exit(0)


if __name__ == '__main__':
    main()
