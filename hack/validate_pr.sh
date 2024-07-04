#!/bin/sh

showError() {
    message="$1"
    textred="\033[1;31m"
    echo "$textred Error: $message" >&2
}

OWNER_NAME='okuda-seminar'
REPO_NAME='Twitter-Clone'

if [ -z "$HEAD" ]; then
    HEAD=$(git rev-parse --abbrev-ref HEAD)
fi

echo "Current Branch: $HEAD"
pr_title=$(gh pr list --repo ${OWNER_NAME}/${REPO_NAME} --head ${HEAD} --json title | jq -r '.[].title')
echo "PR Title: $pr_title"

commit_list=$(gh pr list --repo ${OWNER_NAME}/${REPO_NAME} --head ${HEAD} --json commits)
commit_count=$(echo "${commit_list}" | jq '.[0].commits' | jq length)
if [ "$commit_count" != 1 ]; then
    showError "The count of commits must be 1 but the current commits are ${commit_count}"
    exit 1
fi
commit_sha=$(echo "${commit_list}" | jq -r '.[0].commits[0].oid')
commit_message=$(gh api repos/okuda-seminar/Twitter-Clone/commits/$commit_sha | jq -r '.commit.message')
echo "Commit Message: $commit_message"
escaped=$(printf '%s' "$pr_title" | sed 's/[\[\.*^$/]/\\&/g')
pattern="^${escaped}.*\.$"

if ! expr "$commit_message" : "$pattern" >/dev/null; then
    showError "$commit_message does not start with '$pr_title' and end with a period."
    exit 1
fi
