#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: MPL-2.0
"""
Shared MPL-2.0 SPDX license-header checks used by the PreToolUse/PostToolUse
hooks in .claude/hooks/ and .codex/hooks/.

Both hook sets enforce the same two rules - new guarded files must start
with the SPDX header, and edits must not strip it - the only thing that
differs between Claude Code/VS Code Copilot and Codex CLI is how a given
tool-use event is parsed into a list of (path, content) candidates (a
single file per call vs. an apply_patch covering several). That parsing
stays in each hook's own script; everything else lives here.
"""
import json
import os
import subprocess
import sys

GUARDED_EXTENSIONS = ('.cpp', '.h', '.qml')
HEADER_SEARCH_LINES = 10   # only scan this many lines from the top


def has_spdx_header(content: str) -> bool:
    """Return True when content contains both required SPDX header lines."""
    lines = content.splitlines()[:HEADER_SEARCH_LINES]
    has_copyright = any('SPDX-FileCopyrightText:' in line for line in lines)
    has_license   = any('SPDX-License-Identifier: MPL-2.0' in line for line in lines)
    return has_copyright and has_license


def read_file(path: str) -> str | None:
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


def load_event() -> dict:
    """Parse the hook event JSON from stdin; exit cleanly if it's malformed."""
    try:
        return json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        sys.exit(0)


def deny_creation(path: str) -> None:
    """PreToolUse: deny creating `path` without an SPDX header, then exit."""
    reason = (
        f"Missing MPL-2.0 SPDX license header in '{path}'.\n"
        "Add the following two lines at the very top of the file:\n\n"
        "  // SPDX-FileCopyrightText: <year> <Author Name> <email@example.com>\n"
        "  // SPDX-License-Identifier: MPL-2.0\n\n"
        "See CLAUDE.md for the full license header policy."
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


def block_stripped_header(path: str) -> None:
    """PostToolUse: block because `path` lost its SPDX header, then exit."""
    reason = (
        f"SPDX license header was removed or corrupted in '{path}' by the edit.\n"
        "Restore the following two lines at the very top of the file:\n\n"
        "  // SPDX-FileCopyrightText: <year> <Author Name> <email@example.com>\n"
        "  // SPDX-License-Identifier: MPL-2.0\n\n"
        "See CLAUDE.md for the full license header policy."
    )
    output = {
        "decision": "block",
        "reason": reason,
    }
    sys.stdout.write(json.dumps(output))
    sys.exit(0)


def check_created_files(candidates) -> None:
    """PreToolUse entry point: candidates is an iterable of (path, content).

    Denies (and exits) on the first guarded file missing its SPDX header.
    """
    for path, content in candidates:
        if not path.endswith(GUARDED_EXTENSIONS):
            continue
        if not has_spdx_header(content):
            deny_creation(path)


def check_edited_files(paths) -> None:
    """PostToolUse entry point: paths is an iterable of file paths to re-check on disk.

    Blocks (and exits) on the first guarded file that lost its SPDX header.
    """
    for path in paths:
        if not path.endswith(GUARDED_EXTENSIONS):
            continue
        if not os.path.isfile(path):
            continue
        content = read_file(path)
        if content is None:
            continue
        if not has_spdx_header(content):
            block_stripped_header(path)
