#!/bin/bash
# gh-env.sh: Setup environment for GitHub API calls
# Source this in your shell or run it to export GITHUB_TOKEN

if command -v gh &>/dev/null && gh auth status &>/dev/null; then
  export AUTH_METHOD=\"gh\"
  export GITHUB_TOKEN=$(gh auth token)
else
  export AUTH_METHOD=\"git\"
  if [ -f ~/.hermes/.env ] && grep -q \"^GITHUB_TOKEN=\" ~/.hermes/.env; then
    export GITHUB_TOKEN=$(grep \"^GITHUB_TOKEN=\" ~/.hermes/.env | head -1 | cut -d= -f2 | tr -d '\\n\\r')
  elif grep -q \"github.com\" ~/.git-credentials 2>/dev/null; then
    export GITHUB_TOKEN=$(grep \"github.com\" ~/.git-credentials | head -1 | sed 's|https://[^:]*:\\([^@]*\\)@.*|\\1|')
  fi
fi

if [ -n \"$GITHUB_TOKEN\" ]; then
  echo \"GITHUB_TOKEN is set. Auth method: $AUTH_METHOD\"
else
  echo \"No GITHUB_TOKEN found. Please run 'github-auth' setup.\"
fi
