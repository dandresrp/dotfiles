#!/bin/bash
branch=$(git -C "#{pane_current_path}" symbolic-ref --short HEAD 2>/dev/null)
if [ -n "$branch" ]; then
  echo " $branch"
fi
