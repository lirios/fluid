#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: MPL-2.0
"""
PreToolUse hook: enforce MPL-2.0 SPDX license headers in new .cpp/.h/.qml files.

Works both under the Claude Code CLI (tool_name "Write",
tool_input.file_path) and under VS Code Copilot when it loads this hook set
via chat.hookFilesLocations pointed at .claude/settings.json (tool_name
"create_file", tool_input.filePath) - see .vscode/settings.json.

Shares its SPDX-checking logic with .codex/hooks/check-license-header.py
through scripts/hooks/license_header.py.
"""
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'scripts', 'hooks'))
from license_header import check_created_files, load_event  # noqa: E402

CREATE_TOOL_NAMES = ('Write', 'create_file')


def main() -> None:
    event = load_event()

    tool_name: str   = event.get('tool_name', '')
    tool_input: dict = event.get('tool_input', {})

    if tool_name not in CREATE_TOOL_NAMES:
        sys.exit(0)

    file_path: str = tool_input.get('file_path') or tool_input.get('filePath', '')
    content:   str = tool_input.get('content', '')

    check_created_files([(file_path, content)])

    sys.exit(0)


if __name__ == '__main__':
    main()
