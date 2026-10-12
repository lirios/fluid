#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: MPL-2.0
"""Format added and updated QML files from a Codex apply_patch event."""
from qmlformat import run_hook


def patch_paths(patch: str):
    """Yield surviving paths from apply_patch add, update, and move markers."""
    path = None
    for line in patch.splitlines():
        if line.startswith(('*** Add File: ', '*** Update File: ')):
            if path is not None:
                yield path
            path = line.split(': ', 1)[1]
        elif line.startswith('*** Move to: ') and path is not None:
            path = line.removeprefix('*** Move to: ')
        elif line.startswith('*** '):
            if path is not None:
                yield path
            path = None
    if path is not None:
        yield path


def event_paths(event: dict):
    if event.get('tool_name') != 'apply_patch':
        return
    tool_input = event.get('tool_input', {})
    if isinstance(tool_input, dict):
        patch = tool_input.get('command') or tool_input.get('input', '')
    else:
        patch = tool_input
    if isinstance(patch, str):
        yield from patch_paths(patch)


if __name__ == '__main__':
    run_hook(event_paths)
