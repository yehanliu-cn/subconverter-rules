#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

REMOTE="${REMOTE:-origin}"
BRANCH="${BRANCH:-$(git branch --show-current)}"

log() {
  printf '[sync] %s\n' "$*"
}

die() {
  printf '[sync] %s\n' "$*" >&2
  exit 1
}

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  die "当前目录不是 Git 仓库: $ROOT_DIR"
fi

if [[ -z "$BRANCH" ]]; then
  die "未检测到当前分支，请先切到需要同步的分支"
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  die "检测到未提交改动，已停止同步。请先 commit 或 stash 后再执行。"
fi

if [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
  die "检测到未跟踪文件，已停止同步。请先处理后再执行。"
fi

log "fetch $REMOTE/$BRANCH"
git fetch --prune "$REMOTE"

LOCAL_HEAD="$(git rev-parse HEAD)"
REMOTE_HEAD="$(git rev-parse "$REMOTE/$BRANCH" 2>/dev/null || true)"

if [[ -z "$REMOTE_HEAD" ]]; then
  die "远端不存在分支 $REMOTE/$BRANCH"
fi

BASE_HEAD="$(git merge-base HEAD "$REMOTE/$BRANCH")"

if [[ "$LOCAL_HEAD" == "$REMOTE_HEAD" ]]; then
  log "本地与远端已一致，无需同步"
  exit 0
fi

if [[ "$LOCAL_HEAD" == "$BASE_HEAD" ]]; then
  log "本地落后远端，执行 fast-forward"
  git pull --ff-only "$REMOTE" "$BRANCH"
  log "同步完成，已更新本地到远端最新"
  exit 0
fi

if [[ "$REMOTE_HEAD" == "$BASE_HEAD" ]]; then
  log "本地领先远端，推送到 GitHub"
  git push "$REMOTE" "$BRANCH"
  log "同步完成，远端已更新到本地最新"
  exit 0
fi

log "本地与远端都有新提交，执行 rebase 后推送"
git pull --rebase "$REMOTE" "$BRANCH"
git push "$REMOTE" "$BRANCH"
log "同步完成，本地和远端都已更新"
