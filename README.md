# Claude-cli

A minimal Docker playground to learn and practice [Claude Code CLI](https://code.claude.com/docs/en/overview), following Anthropic's official docs, tutorials, and courses.

---

## 🛡️ Security & Philosophy

This project follows the **"AI Jail"** concept—a security philosophy for running autonomous AI agents. As discussed by **Fabio Akita** in his article [ai-jail: Sandbox para Agentes de IA](https://akitaonrails.com/2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real/), giving an AI agent full access to your host shell is a significant security risk.

### Why use a Sandbox?
AI agents can execute arbitrary commands, install dependencies (npm/pip), and modify files. Without a sandbox:

* **Credential Leakage:** A hallucinated or malicious command could exfiltrate your `~/.ssh` or `~/.aws` keys.
* **System Damage:** An accidental `rm -rf` could wipe your host OS instead of just the project folder.
* **Supply-Chain Risks:** Malicious code hidden in third-party libraries could compromise your entire machine.



### Docker as your Jail
While Akita's `ai-jail` tool is optimized for Linux/macOS using `bubblewrap`, this project uses **Docker** to provide a similar "Default Deny" layer for Windows and Cross-Platform users:

* **Isolated Filesystem:** Claude only sees the `/workspace` folder and an ephemeral home directory.
* **Network Control:** You can monitor and restrict traffic leaving the container.
* **Persistence Control:** Only the specific `.claude` auth folder is shared, keeping the rest of your home directory invisible.

---

## Prerequisites

Before you start, make sure you have:

1. **Docker Desktop** — [Install Docker Desktop](https://docs.docker.com/get-docker/) (includes Docker Compose)
2. **A Claude subscription** — [Pro, Max, Team, or Enterprise](https://claude.com/pricing) (recommended), or a [Claude Console](https://console.anthropic.com/) account for API access
3. **Git** — to clone this repository

---

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/Edengb/claude-cli.git
cd claude-cli
```

### 2. Create your `.env` file

```DOS
copy .env.example .env
```

On Windows (PowerShell) or Linux/macOS:

```Bash
cp .env.example .env
```

Open `.env` and set your Windows username (run `echo %USERNAME%` in CMD to find it):

```env
WINDOWS_USERNAME=YourWindowsUsername
```

This is used to mount your host `~/.claude` credentials folder into the container,
so you stay logged in across container rebuilds — the same approach used in `.devcontainer` setups.

Optionally, if you use Console/API access instead of a Claude subscription:

```env
ANTHROPIC_API_KEY=sk-ant-...
```

> `.env` is gitignored and never committed.

### 3. Build the image

```bash
docker compose build
```

### 4. Run the playground

```bash
docker compose run --rm claude-playground
```

### 5. Log in and start Claude Code

```bash
claude
# First run: follow the prompt to log in via browser
```

Your credentials are saved to `C:\Users\<you>\.claude` on your host machine,
so you only need to log in once.

---

## How it works

The environment is built on a **Debian Slim** image. To ensure a smooth installation, the `Dockerfile` performs the following:

* **Non-Root Execution:** The native installer requires a real home directory to correctly place the binary in `~/.local/bin`.

* **Persistent Auth:** By mounting the host's `.claude` directory, your login session remains active even if you delete or rebuild the container.

* **Workspace Sync:** The `/workspace` folder inside the container is linked to your local `workspace/` folder, allowing Claude to see and edit your code in real-time.

---

## Project Structure

```
claude-cli/
├── Dockerfile          # Debian Slim + official Claude Code native installer (non-root)
├── docker-compose.yml  # Container config: TTY, env, credential + workspace mounts
├── entrypoint.sh       # Startup banner and environment check
├── .env.example        # Template for your local .env
├── workspace/          # ← Your files live here (mounted from host)
└── README.md
```

---

## Useful Commands

| Command | Description |
|---|---|
| `claude` | Start an interactive Claude Code session |
| `claude "fix the build error"` | Run a one-time task |
| `claude -p "explain this function"` | One-off query, then exit |
| `claude -c` | Continue the most recent conversation |
| `/help` | Show available Claude Code commands |
| `/login` | Switch accounts inside Claude Code |
| `exit` or Ctrl+D | Exit Claude Code or the container |

---

## Resources

- [Claude Code Quickstart](https://code.claude.com/docs/en/quickstart)
- [Claude Code Docs](https://code.claude.com/docs/en/overview)
- [Common Workflows](https://code.claude.com/docs/en/common-workflows)
- [Best Practices](https://code.claude.com/docs/en/best-practices)
- [CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Anthropic Discord](https://www.anthropic.com/discord)
