---
name: codex
description: |
  与 Codex AI 协作进行代码审查、规划和调试。
  触发词：codex、review、audit、审查、plan、规划、debug、定位、analyze、分析。
  Use when: review/audit code, plan/design features, debug/locate bugs.
user-invocable: true
allowed-tools:
  - mcp__codex__codex
  - Read
  - Grep
  - Glob
  - Bash(git:*)
  - Bash(bash:scripts/pre-codex-check.sh)
hooks:
  PreToolUse:
    - matcher: "mcp__codex__codex"
      hooks:
        - type: command
          command: "bash scripts/pre-codex-check.sh"
---

# Codex 协作指南

当用户提到 Codex 时，自动激活此协作流程。

## 前置条件

使用此 Skill 前需要安装 CodexMCP 服务器。详见 [README.md](README.md) 安装说明。

**完整的协作规则和模式详见：**`reference/shared-patterns.md`

## 核心规则（简要）

> 此处使用 1-6 编号简化展示，与 `reference/shared-patterns.md` 的 0-5 编号内容一致。

1. **计划(plan)文件检测优先** - 调用前请将前面生成的计划(plan)文件的路径显示传递给codex
2. **先自检再调用** - 必须先输出初步分析，再调用 Codex
3. **信息不足时提问** - 信息不明确时先追问用户
4. **安全调用** - 使用 `sandbox="read-only"`
5. **只读输出** - 仅给出 unified diff patch 或建议
6. **质疑验证** - 交叉验证 Codex 结论

*详细说明见 reference/shared-patterns.md*

## 计划文件传递

若需要计划上下文，通过 `plan-path=<path>` 显式传递：
- 示例：`/codex-review src/app.py plan-path=.claude/plans/feature.md`

**详细说明见：** `reference/shared-patterns.md` 的"计划文档集成"章节

## 场景识别

根据用户意图自动选择合适的协作模式：

| 场景关键词             | 协作模式 | 说明                              |
| ---------------------- | -------- | --------------------------------- |
| 审查、review、检查代码 | 代码审查 | 发现 bugs、安全问题、代码质量问题 |
| 规划、plan、设计、实现 | 需求分析 | 生成实现计划、任务拆解            |
| debug、报错、定位、bug | 问题定位 | 根因分析、修复建议                |

## 工作流程（简要）

Codex 协作遵循以下工作流程：

### >>> 前置：计划文件处理 <<<

若 `plan-path=<path>` 参数存在：Read 文件，判断相关性，若相关则在 PROMPT 中包含路径。

---

1. **确认任务类型** - 分析用户意图（代码审查/需求分析/问题定位）
2. **收集上下文** - 获取相关文件、错误信息、需求描述
3. **初步分析**（必须）- 输出你的初步判断
4. **调用 Codex** - 使用 `mcp__codex__codex` 工具，**若有相关计划则在 PROMPT 中包含计划文件路径**
5. **质疑与验证** - 审视 Codex 结论
6. **输出结论** - 整合分析结果

**完整的工作流程和 Codex 调用模板详见：**`reference/shared-patterns.md`

## SESSION_ID 管理（简要）

- 新会话：不传 SESSION_ID
- 继续会话：传入之前的 SESSION_ID
- 输出时回显 session ID

*详细的会话管理规范见 reference/shared-patterns.md*

## 命令参考

以下命令的详细文档见 `commands/` 目录：

- **代码审查**：详见 `commands/codex-review.md` - 审查代码改动、发现问题
- **需求分析**：详见 `commands/codex-plan.md` - 规划功能、拆解任务
- **Debug 定位**：详见 `commands/codex-debug.md` - 定位问题根因、修复建议
