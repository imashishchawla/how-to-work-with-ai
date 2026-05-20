# 10 - Troubleshooting AI Tool Setup

## Claude Code

### `claude: command not found`

Check Node.js and npm global bin path:

```bash
node --version
npm --version
npm bin -g
```

Reinstall:

```bash
npm install -g @anthropic-ai/claude-code
```

### Agent edits too much

Use a stricter prompt:

```text
Do not edit files. Inspect only and produce a plan. Wait for approval before making changes.
```

## Codex CLI

### Install or upgrade

```bash
npm i -g @openai/codex@latest
codex --version
```

### Start in a repo

```bash
cd /path/to/repo
codex
```

## OpenCode

### Install

```bash
curl -fsSL https://opencode.ai/install | bash
```

### Check binary path

```bash
which opencode
opencode --version
```

## IBM Bob (Bob Shell)

### `bob: command not found`

Reinstall Bob from the official download page:

```text
https://bob.ibm.com/download
```

After install, restart your terminal and verify:

```bash
bob --version
```

### Sign-in issues

Make sure you have a valid IBMid. Sign in through the app or browser flow:

```bash
bob shell
```

If authentication fails, check your IBMid credentials and retry the browser-based login from the app.

### Bob Shell is not responding

Restart the terminal and relaunch:

```bash
bob shell
```

If the issue persists, check Bob's status page or your organization's proxy/firewall settings.

---

## Ollama

### API not responding

```bash
curl http://localhost:11434/api/tags
```

If it fails:

- Confirm Ollama is running.
- Restart the app or service.
- Check firewall or port conflicts.

## llama.cpp

### Model server not reachable

```bash
curl http://localhost:8080/v1/models
```

If it fails:

- Confirm the server process is running.
- Confirm the port number.
- Check model path.
- Check memory errors in terminal logs.

### Out of memory

Try:

- Smaller model
- Lower quantization size
- Smaller context window
- Fewer parallel requests

## Bad AI answers

Common causes:

- Weak prompt
- Missing context
- Wrong model for the task
- Too much irrelevant context
- Hallucination
- No verification step

Better prompt:

```text
Use only the evidence I provide. If the evidence is not enough, say so. Separate facts, assumptions, and next checks.
```
