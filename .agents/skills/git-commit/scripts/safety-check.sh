#!/usr/bin/env bash

# Copyright 2026 The Flux authors. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

# This script checks whether HEAD can be safely amended to add an
# Assisted-by trailer. Prints "safe" when all four conditions hold,
# otherwise "skip:<reason>".
#
# Conditions:
#   - HEAD is not contained by any remote branch
#   - HEAD does not already carry an Assisted-by trailer
#   - HEAD is not a merge commit
#   - No rebase, cherry-pick, revert, or bisect is in progress

# Prerequisites
# - git

set -o errexit
set -o pipefail

check_pushed() {
  if [[ -n "$(git branch -r --contains HEAD 2>/dev/null)" ]]; then
    echo "skip:pushed"
    exit 0
  fi
}

check_trailered() {
  if git log -1 --format=%B | git interpret-trailers --parse | grep -qi '^Assisted-by:'; then
    echo "skip:trailered"
    exit 0
  fi
}

check_merge() {
  local parents
  parents=$(git log -1 --format=%P)
  if [[ $(echo "$parents" | wc -w) -gt 1 ]]; then
    echo "skip:merge"
    exit 0
  fi
}

check_inprogress() {
  local git_dir
  git_dir=$(git rev-parse --git-dir)
  for marker in rebase-merge rebase-apply CHERRY_PICK_HEAD REVERT_HEAD BISECT_LOG; do
    if [[ -e "$git_dir/$marker" ]]; then
      echo "skip:inprogress"
      exit 0
    fi
  done
}

# Main
check_pushed
check_trailered
check_merge
check_inprogress
echo "safe"
