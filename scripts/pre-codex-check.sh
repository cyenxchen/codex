#!/bin/bash
# Pre-Codex verification hook
# 输出提示信息，提醒 Claude 在调用 Codex 前完成验证

cat << 'EOF'
⚠️ PRE-CODEX VERIFICATION CHECKLIST:

Before calling Codex, ensure you have:
1. ✓ Check if plan-path=<path> was provided
2. ✓ If plan-path provided, Read the plan file
3. ✓ Output preliminary analysis
4. ✓ Use sandbox="read-only"

If any step is missing, STOP and complete it first.
EOF
