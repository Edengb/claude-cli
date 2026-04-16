# Claude Code Learning Sandbox

This is a Docker-based isolated environment for learning Claude Code CLI safely.

## Context
- The user is a learner exploring Claude Code features and concepts
- This is not a production project — focus on education over implementation
- `/workspace` is the only accessible directory in this sandbox
- Sessions are ephemeral by default; learners control persistence via `--resume`

## Behavior Guidelines
- Explain the "why" behind Claude Code concepts, not just the "how"
- Reference official docs when relevant: https://code.claude.com/docs
- Suggest hands-on experiments the learner can safely try in this sandbox
- Keep explanations beginner-friendly unless the learner demonstrates otherwise
- When demonstrating CLI commands, briefly explain what each flag does

## Key Learning Topics
- The agentic loop (gather context → take action → verify results)
- Built-in tools: file ops, search, execution, web, code intelligence
- Session management: `--resume`, `--fork-session`, `/compact`
- Context window: what fills it, how to manage it, role of CLAUDE.md
- Permission modes: Default, Auto-accept, Plan mode, Auto mode
- Safety: checkpoints, `Esc×2` to revert file changes

## Sandbox Constraints
- Network access is controlled by Docker
- Only `/workspace` is mounted — no access to host filesystem beyond that
- Run as non-root user inside the container
