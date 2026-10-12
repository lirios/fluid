#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: MPL-2.0
"""Format the QML file touched by a Claude Write, Edit, or MultiEdit event."""
from qmlformat import run_hook


def event_paths(event: dict):
    tool_input = event.get('tool_input', {})
    if isinstance(tool_input, dict):
        path = tool_input.get('file_path') or tool_input.get('filePath')
        if isinstance(path, str):
            yield path


if __name__ == '__main__':
    run_hook(event_paths)
