# Local LLM Setup on Mac

This guide explains how to install and run a local LLM on macOS using:

- macOS
- Homebrew
- Python
- Hugging Face CLI
- llama.cpp
- GGUF model files from Hugging Face

The goal is to run a local OpenAI-compatible LLM server on:

```bash
http://localhost:1234/v1
```

---

## 1. What We Are Installing

We will install:

| Tool | Purpose |
|---|---|
| Homebrew | Package manager for macOS |
| Python | Required for Hugging Face CLI |
| Hugging Face CLI | Downloads models from Hugging Face |
| llama.cpp | Runs GGUF LLM models locally |
| GGUF model | Quantized local LLM model file |

---

## 2. Recommended Mac Requirements

| Mac RAM | Recommended Model Size |
|---|---|
| 8 GB | 3B to 4B Q4 |
| 16 GB | 7B to 8B Q4 |
| 24 GB | 8B to 14B Q4 |
| 32 GB | 14B to 27B Q4 |
| 64 GB+ | 27B to 35B Q4/Q5 |

For most users, start with:

```text
Qwen3 8B GGUF Q4_K_M
```

This gives a good balance between quality, speed, and memory usage.

---

## 3. Install Homebrew

If Homebrew is not already installed, run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Verify installation:

```bash
brew --version
```

---

## 4. Install Required Tools

Install Git, Python, CMake, and llama.cpp:

```bash
brew install git python cmake llama.cpp
```

Verify `llama.cpp` installation:

```bash
llama-server --help
```

If this command shows help output, `llama.cpp` is installed correctly.

---

## 5. Install Hugging Face CLI

Install the Hugging Face Hub CLI:

```bash
python3 -m pip install --upgrade huggingface_hub
```

Verify:

```bash
hf --help
```

If `hf` does not work, try:

```bash
python3 -m huggingface_hub --help
```

---

## 6. Login to Hugging Face

Some models require authentication or license acceptance.

Login with:

```bash
hf auth login
```

Create a Hugging Face access token from:

```text
https://huggingface.co/settings/tokens
```

Use a token with read access.

---

## 7. Create a Local Folder for Models

```bash
mkdir -p ~/local-llm/models
cd ~/local-llm/models
```

Recommended project structure:

```text
local-llm/
├── README.md
└── models/
    └── qwen3-8b/
        └── model.gguf
```

---

## 8. Choose a Model from Hugging Face

For Mac, use GGUF models.

Recommended model options:

| Use Case | Model Type |
|---|---|
| General chat | Qwen, Llama, Gemma, Mistral |
| Coding | Qwen Coder, DeepSeek Coder, CodeLlama |
| Fast lightweight testing | 3B or 4B models |
| Better quality | 7B, 8B, 14B models |
| Advanced local setup | 27B, 32B, 35B models |

Recommended quantization:

```text
Q4_K_M
```

### What is GGUF?

GGUF is a model file format commonly used with `llama.cpp`.

A GGUF file usually looks like this:

```text
Qwen3-8B-Q4_K_M.gguf
```

Meaning:

| Part | Meaning |
|---|---|
| Qwen3 | Model family/version |
| 8B | Approximate parameter size |
| Q4_K_M | Quantization type |
| .gguf | Model file format |

---

## 9. Download a Model from Hugging Face

Example: download Qwen3 8B GGUF with Q4_K_M quantization.

```bash
hf download Qwen/Qwen3-8B-GGUF \
  --include "*Q4_K_M.gguf" \
  --local-dir ~/local-llm/models/qwen3-8b
```

Check the downloaded file:

```bash
ls -lh ~/local-llm/models/qwen3-8b
```

You should see a `.gguf` file.

Example:

```text
Qwen3-8B-Q4_K_M.gguf
```

---

## 10. Find the Exact Model File Name

Use this command:

```bash
find ~/local-llm/models -name "*.gguf"
```

Example output:

```bash
/Users/yourname/local-llm/models/qwen3-8b/Qwen3-8B-Q4_K_M.gguf
```

Copy this path. You will use it in the next step.

---

## 11. Run the Local LLM Server

Start the model server:

```bash
llama-server \
  -m ~/local-llm/models/qwen3-8b/Qwen3-8B-Q4_K_M.gguf \
  --host 127.0.0.1 \
  --port 1234 \
  -c 8192
```

Explanation:

| Option | Meaning |
|---|---|
| `-m` | Path to the GGUF model |
| `--host 127.0.0.1` | Runs only on your Mac |
| `--port 1234` | Local API port |
| `-c 8192` | Context length |

The server should start at:

```bash
http://127.0.0.1:1234
```

---

## 12. Test the Server

Open a new terminal window and run:

```bash
curl http://127.0.0.1:1234/v1/models
```

If the server is running, you should see a response listing the local model.

---

## 13. Test Chat Completion

Run:

```bash
curl http://127.0.0.1:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "local-model",
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful local AI assistant."
      },
      {
        "role": "user",
        "content": "Write a short README intro for a local LLM project."
      }
    ],
    "temperature": 0.7
  }'
```

If you get a text response, your local LLM is working.

---

## 14. Use the Local LLM with OpenAI-Compatible Apps

Use this base URL in tools that support OpenAI-compatible APIs:

```bash
http://127.0.0.1:1234/v1
```

Use any dummy API key, for example:

```bash
local
```

Set environment variables:

```bash
export OPENAI_BASE_URL="http://127.0.0.1:1234/v1"
export OPENAI_API_KEY="local"
```

---

## 15. Optional: Run Model Directly from Hugging Face

Some GGUF models can be started directly using the Hugging Face repo name.

Example:

```bash
llama-server -hf Qwen/Qwen3-8B-GGUF:Q4_K_M \
  --host 127.0.0.1 \
  --port 1234 \
  -c 8192
```

This downloads and caches the model automatically.

---

## 16. Example with a Larger Model Name

Example model name:

```text
Qwen3.6-35B-A3B-MTP-GGUF
```

Breakdown:

| Part | Meaning |
|---|---|
| Qwen3.6 | Model family and version |
| 35B | Approximate total parameter size |
| A3B | Active parameter pattern or architecture-specific naming |
| MTP | Multi-token prediction or model-specific feature |
| GGUF | File format used by llama.cpp |

Important note:

Large models like `35B` need much more RAM. On Mac, use them only if you have enough unified memory.

Recommended for 35B models:

```text
64 GB RAM or higher
```

For 16 GB or 24 GB Macs, use smaller 7B, 8B, or 14B models.

---

## 17. Run with a Larger Context Window

Example:

```bash
llama-server \
  -m ~/local-llm/models/qwen3-8b/Qwen3-8B-Q4_K_M.gguf \
  --host 127.0.0.1 \
  --port 1234 \
  -c 16384
```

Use larger context only if your Mac has enough memory.

---

## 18. Run on Local Network

By default, this guide uses:

```bash
127.0.0.1
```

This means only your Mac can access the LLM.

If you want other devices on your network to access it, run:

```bash
llama-server \
  -m ~/local-llm/models/qwen3-8b/Qwen3-8B-Q4_K_M.gguf \
  --host 0.0.0.0 \
  --port 1234 \
  -c 8192
```

Then access it from another device using your Mac IP:

```bash
http://YOUR_MAC_IP:1234/v1
```

Find your Mac IP:

```bash
ipconfig getifaddr en0
```

Security note:

Only expose the server to trusted devices on your local network.

---

## 19. Useful Commands

Stop the server:

```bash
CTRL + C
```

Check model folder size:

```bash
du -sh ~/local-llm/models/*
```

List downloaded GGUF files:

```bash
find ~/local-llm/models -name "*.gguf"
```

Check if port 1234 is already in use:

```bash
lsof -i :1234
```

Kill a process using port 1234:

```bash
kill -9 <PID>
```

---

## 20. Troubleshooting

### Issue: `hf: command not found`

Fix:

```bash
python3 -m pip install --upgrade huggingface_hub
```

Then restart your terminal.

---

### Issue: `llama-server: command not found`

Fix:

```bash
brew install llama.cpp
```

Then verify:

```bash
llama-server --help
```

---

### Issue: Model file not found

Find the actual file:

```bash
find ~/local-llm/models -name "*.gguf"
```

Then update the `-m` path in your command.

---

### Issue: Mac becomes slow

Use a smaller model.

Recommended downgrade path:

```text
35B -> 14B -> 8B -> 4B -> 3B
```

Use `Q4_K_M` instead of larger quantizations.

---

### Issue: Out of memory

Try a smaller model or shorter context:

```bash
-c 4096
```

Instead of:

```bash
-c 8192
```

---

### Issue: Port already in use

Use another port:

```bash
llama-server \
  -m /path/to/model.gguf \
  --host 127.0.0.1 \
  --port 8080
```

Then test:

```bash
curl http://127.0.0.1:8080/v1/models
```

---

## 21. Best Starting Setup

For a good first setup on Mac:

```bash
mkdir -p ~/local-llm/models

hf download Qwen/Qwen3-8B-GGUF \
  --include "*Q4_K_M.gguf" \
  --local-dir ~/local-llm/models/qwen3-8b

llama-server \
  -m ~/local-llm/models/qwen3-8b/Qwen3-8B-Q4_K_M.gguf \
  --host 127.0.0.1 \
  --port 1234 \
  -c 8192
```

Test:

```bash
curl http://127.0.0.1:1234/v1/models
```

---

## 22. Done

Your local LLM is now running on your Mac.

Local API endpoint:

```bash
http://127.0.0.1:1234/v1
```

You can now connect this endpoint to local tools, AI coding assistants, private chat apps, or your own applications.

-------------
mkdir -p ~/models/gguf/qwen3-8b

hf download Qwen/Qwen3-8B-GGUF \
  --include "*Q4_K_M.gguf" \
  --local-dir ~/models/gguf/qwen3-8b
  ----------------