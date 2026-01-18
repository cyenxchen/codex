#!/bin/bash
# Pre-Codex verification hook
# 输出提示信息，提醒 Claude 在调用 Codex 前完成验证

cat << 'EOF'
⚠️ PRE-CODEX VERIFICATION CHECKLIST:

Before calling Codex, ensure you have:
1. ✓ Glob('.claude/plans/*.md') - Check project plans
2. ✓ Glob('~/.claude/plans/*.md') - Check global plans
3. ✓ Read relevant plan files if found
4. ✓ Output preliminary analysis
5. ✓ Use sandbox="read-only"

If any step is missing, STOP and complete it first.
EOF
