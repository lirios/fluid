#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: MPL-2.0
"""Shared best-effort QML formatting for Claude and Codex PostToolUse hooks.

Import run_hook with an agent-specific path parser, or execute this script
directly to handle either agent's event format.
"""
import json
import subprocess
import sys


def run_hook(event_paths) -> None:
    """Read a hook event and format the QML paths supplied by its parser."""
    try:
        event = json.load(sys.stdin)
    except (ValueError, UnicodeError):
        return
    if not isinstance(event, dict):
        return

    cwd = event.get('cwd')
    if not isinstance(cwd, str) or not cwd:
        cwd = None

    for path in dict.fromkeys(event_paths(event)):
        if not path.endswith('.qml'):
            continue
        try:
            subprocess.run(
                ['qmlformat', '--inplace', '--newline', 'unix',
                 '--semicolon-rule', 'always', path],
                cwd=cwd,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                timeout=5,
                check=False,
            )
        except (OSError, subprocess.TimeoutExpired):
            pass


if __name__ == '__main__':
    from qmlformat_claude import event_paths as claude_paths
    from qmlformat_codex import event_paths as codex_paths

    def event_paths(event: dict):
        parser = codex_paths if event.get('tool_name') == 'apply_patch' else claude_paths
        yield from parser(event)

    run_hook(event_paths)
