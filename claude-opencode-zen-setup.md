# Claude Code / OpenCode Zen Setup Guide

This guide explains how to install and configure Claude Code / OpenCode with the Zen gateway:

```text
https://opencode.ai/zen
```

This setup uses:

- Claude Code
- OpenCode Zen endpoint
- Anthropic-compatible environment variables
- `minimax-m2.5-free` model
- Custom status line
- `acceptEdits` permission mode
- Dark Daltonized theme

---

## 1. Goal

After completing this setup, Claude Code should use the Zen gateway instead of the default Anthropic endpoint.

Target configuration:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://opencode.ai/zen",
    "ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxx",
    "ANTHROPIC_MODEL": "minimax-m2.5-free",
    "ENABLE_TOOL_SEARCH": "true"
  },
  "permissions": {
    "defaultMode": "acceptEdits"
  },
  "statusLine": {
    "type": "command",
    "command": "bash /Users/ashishchawla/.claude/statusline-command.sh"
  },
  "effortLevel": "medium",
  "theme": "dark-daltonized"
}
```

---

## 2. Important Note About API Key

For Zen gateway, prefer:

```json
"ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxx"
```

Instead of:

```json
"ANTHROPIC_API_KEY": "sk-xxxxxxx"
```

Do not use both together.

Why?

- `ANTHROPIC_API_KEY` is usually sent as an `X-Api-Key` header.
- `ANTHROPIC_AUTH_TOKEN` is usually sent as a Bearer token.
- Many gateway/proxy services expect Bearer token authentication.

---

## 3. Install Claude Code

Install Claude Code using npm:

```bash
npm install -g @anthropic-ai/claude-code
```

Verify installation:

```bash
claude --version
```

Run health check:

```bash
claude doctor
```

If `claude` is not found, check your npm global path:

```bash
npm bin -g
```

---

## 4. Install OpenCode

Install OpenCode:

```bash
curl -fsSL https://opencode.ai/install | bash
```

Restart your terminal or reload your shell:

```bash
source ~/.zshrc
```

Verify:

```bash
opencode --version
```

If it does not work, check your shell path:

```bash
echo $PATH
```

---

## 5. Create Claude Config Folder

Create the Claude configuration folder:

```bash
mkdir -p ~/.claude
```

---

## 6. Backup Existing Claude Settings

Before changing anything, create a backup:

```bash
cp ~/.claude/settings.json ~/.claude/settings.backup.json 2>/dev/null || true
```

---

## 7. Create Claude Settings File

Open the settings file:

```bash
nano ~/.claude/settings.json
```

Paste this configuration:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://opencode.ai/zen",
    "ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxx",
    "ANTHROPIC_MODEL": "minimax-m2.5-free",
    "ENABLE_TOOL_SEARCH": "true"
  },
  "permissions": {
    "defaultMode": "acceptEdits"
  },
  "statusLine": {
    "type": "command",
    "command": "bash /Users/ashishchawla/.claude/statusline-command.sh"
  },
  "effortLevel": "medium",
  "theme": "dark-daltonized"
}
```

Replace this:

```text
sk-xxxxxxx
```

With your real Zen API key.

Save the file:

```text
CTRL + O
Enter
CTRL + X
```

---

## 8. Safer Generic Version

If you want this to work for any Mac username, use `$HOME` instead of a hardcoded path.

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://opencode.ai/zen",
    "ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxx",
    "ANTHROPIC_MODEL": "minimax-m2.5-free",
    "ENABLE_TOOL_SEARCH": "true"
  },
  "permissions": {
    "defaultMode": "acceptEdits"
  },
  "statusLine": {
    "type": "command",
    "command": "bash $HOME/.claude/statusline-command.sh"
  },
  "effortLevel": "medium",
  "theme": "dark-daltonized"
}
```

---

## 9. Validate JSON

Run:

```bash
python3 -m json.tool ~/.claude/settings.json
```

If the JSON is valid, it will print the formatted config.

If there is an error, fix the line mentioned in the output.

---

## 10. Create Status Line Script

Create the status line script:

```bash
nano ~/.claude/statusline-command.sh
```

Paste this:

```bash
#!/usr/bin/env bash

# Simple Claude Code status line for Zen/OpenCode setup

MODEL="${ANTHROPIC_MODEL:-unknown-model}"
BASE_URL="${ANTHROPIC_BASE_URL:-default-endpoint}"

PROJECT_DIR="$(basename "$PWD")"

printf "🚀 %s  |  🧠 %s  |  🌐 %s  |  🌙 ready\n" "$PROJECT_DIR" "$MODEL" "$BASE_URL"
```

Save:

```text
CTRL + O
Enter
CTRL + X
```

Make it executable:

```bash
chmod +x ~/.claude/statusline-command.sh
```

Test it:

```bash
bash ~/.claude/statusline-command.sh
```

Expected output should look similar to:

```text
🚀 my-project  |  🧠 minimax-m2.5-free  |  🌐 https://opencode.ai/zen  |  🌙 ready
```

---

## 11. Test Claude Code

Run:

```bash
claude doctor
```

Then:

```bash
claude
```

Ask a simple test question:

```text
Say hello and confirm which model you are using.
```

---

## 12. Test Using Direct Environment Variables

If `settings.json` does not work, test by passing environment variables directly:

```bash
ANTHROPIC_BASE_URL="https://opencode.ai/zen" \
ANTHROPIC_AUTH_TOKEN="sk-xxxxxxx" \
ANTHROPIC_MODEL="minimax-m2.5-free" \
ENABLE_TOOL_SEARCH="true" \
claude
```

If this works, the issue is likely in:

- `~/.claude/settings.json`
- project-level override config
- invalid JSON
- status line script
- old terminal session

---

## 13. Check Claude Config

Show current settings:

```bash
cat ~/.claude/settings.json
```

Validate again:

```bash
python3 -m json.tool ~/.claude/settings.json
```

Check Claude config:

```bash
claude config list
```

---

## 14. Check for Project-Level Overrides

Claude Code can use config files inside a project.

From your project folder, run:

```bash
find . -path "*/.claude/settings*.json" -type f -print
```

If you see files like:

```text
./.claude/settings.json
./.claude/settings.local.json
```

They may override or conflict with your global config.

Review them:

```bash
cat .claude/settings.json
cat .claude/settings.local.json
```

---

## 15. Recommended Minimal Project Config

If you want a project-specific config, create:

```bash
mkdir -p .claude
nano .claude/settings.local.json
```

Example:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://opencode.ai/zen",
    "ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxx",
    "ANTHROPIC_MODEL": "minimax-m2.5-free",
    "ENABLE_TOOL_SEARCH": "true"
  },
  "permissions": {
    "defaultMode": "acceptEdits"
  }
}
```

Use project-level config only when you want different behavior per project.

---

## 16. Do Not Start with Too Many Plugins

Start with a minimal config first.

Avoid adding many plugins until the base connection works.

Recommended first test config:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://opencode.ai/zen",
    "ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxx",
    "ANTHROPIC_MODEL": "minimax-m2.5-free",
    "ENABLE_TOOL_SEARCH": "true"
  },
  "permissions": {
    "defaultMode": "acceptEdits"
  },
  "effortLevel": "medium",
  "theme": "dark-daltonized"
}
```

Once this works, add status line.

Once status line works, add plugins slowly.

---

## 17. Suggested Safe Plugin Add-On

After base setup works, you can test with a few plugins:

```json
{
  "enabledPlugins": {
    "code-review@claude-plugins-official": true,
    "frontend-design@claude-plugins-official": true,
    "remember@claude-plugins-official": true
  }
}
```

Do not add a large plugin list until each plugin is confirmed installed and compatible.

---

## 18. Troubleshooting

### Problem: Claude still uses default Anthropic endpoint

Check:

```bash
cat ~/.claude/settings.json
```

Make sure this is present:

```json
"ANTHROPIC_BASE_URL": "https://opencode.ai/zen"
```

Then restart terminal and run:

```bash
claude doctor
```

---

### Problem: Authentication error

Make sure you use:

```json
"ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxx"
```

Not:

```json
"ANTHROPIC_API_KEY": "sk-xxxxxxx"
```

Also make sure your key is valid.

---

### Problem: Model not found

The model name may not be valid for the Zen gateway.

Current configured model:

```text
minimax-m2.5-free
```

Try checking available models from the provider/gateway dashboard if available.

---

### Problem: Status line is not working

Check the script:

```bash
ls -lah ~/.claude/statusline-command.sh
```

Make executable:

```bash
chmod +x ~/.claude/statusline-command.sh
```

Run manually:

```bash
bash ~/.claude/statusline-command.sh
```

If it fails, temporarily remove this block from settings:

```json
"statusLine": {
  "type": "command",
  "command": "bash /Users/ashishchawla/.claude/statusline-command.sh"
}
```

Then test Claude again.

---

### Problem: JSON is invalid

Run:

```bash
python3 -m json.tool ~/.claude/settings.json
```

Common mistakes:

- Missing comma
- Extra comma after last item
- Curly quotes instead of normal quotes
- Comments inside JSON
- Broken path string

---

### Problem: Claude config is ignored

Check location:

```bash
ls -lah ~/.claude/settings.json
```

Check project config:

```bash
find . -path "*/.claude/settings*.json" -type f -print
```

Check active config:

```bash
claude config list
```

---

## 19. One-Command Setup

This command creates the config and status line script.

Replace `sk-xxxxxxx` with your actual key before running.

```bash
mkdir -p ~/.claude

cat > ~/.claude/settings.json <<'EOF'
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://opencode.ai/zen",
    "ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxx",
    "ANTHROPIC_MODEL": "minimax-m2.5-free",
    "ENABLE_TOOL_SEARCH": "true"
  },
  "permissions": {
    "defaultMode": "acceptEdits"
  },
  "statusLine": {
    "type": "command",
    "command": "bash $HOME/.claude/statusline-command.sh"
  },
  "effortLevel": "medium",
  "theme": "dark-daltonized"
}
EOF

cat > ~/.claude/statusline-command.sh <<'EOF'
#!/usr/bin/env bash

MODEL="${ANTHROPIC_MODEL:-unknown-model}"
BASE_URL="${ANTHROPIC_BASE_URL:-default-endpoint}"
PROJECT_DIR="$(basename "$PWD")"

printf "🚀 %s  |  🧠 %s  |  🌐 %s  |  🌙 ready\n" "$PROJECT_DIR" "$MODEL" "$BASE_URL"
EOF

chmod +x ~/.claude/statusline-command.sh

python3 -m json.tool ~/.claude/settings.json

bash ~/.claude/statusline-command.sh
```

Then run:

```bash
claude doctor
claude
```

---

## 20. Final Recommended Config

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://opencode.ai/zen",
    "ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxx",
    "ANTHROPIC_MODEL": "minimax-m2.5-free",
    "ENABLE_TOOL_SEARCH": "true"
  },
  "permissions": {
    "defaultMode": "acceptEdits"
  },
  "statusLine": {
    "type": "command",
    "command": "bash $HOME/.claude/statusline-command.sh"
  },
  "effortLevel": "medium",
  "theme": "dark-daltonized"
}
```

---

## 21. Final Test Checklist

Run these commands:

```bash
claude --version
claude doctor
python3 -m json.tool ~/.claude/settings.json
bash ~/.claude/statusline-command.sh
claude
```

If all commands work, your Claude Code + OpenCode Zen setup is ready.

---

## 22. Notes

Keep your real API key private.

Do not commit this file with your real key to GitHub.

Recommended safe pattern:

```json
"ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxx"
```

Use placeholder values in public documentation.
