# 09 - Security and Governance

AI tools can make engineers faster, but they can also increase risk if they are given secrets, production access, or unchecked permissions.

## Never send these to AI tools

- API keys
- Private keys
- Passwords
- Session tokens
- Customer secrets
- Production credentials
- Raw kubeconfigs
- Cloud access keys
- Proprietary data unless approved

## Redaction example

Bad:

```text
AWS_SECRET_ACCESS_KEY=real-secret-value
```

Good:

```text
AWS_SECRET_ACCESS_KEY=<redacted>
```

## Governance checklist

Before using a new AI tool:

- Is it approved by your organization?
- Where does data go?
- Is data used for training?
- Can logging be disabled or controlled?
- Can secrets be blocked?
- Can tool permissions be limited?
- Is there audit history?
- Can the tool access the filesystem?
- Can the tool run commands?

## Local model security

For local LLMs:

- Bind endpoints to `127.0.0.1` by default.
- Use firewall rules if exposing to LAN.
- Do not expose `/v1/chat/completions` publicly.
- Do not run unknown models or scripts from random sources.
- Keep model files and tools updated.
- Review downloads and checksums where available.

## Coding agent security

For repository agents:

- Start with read-only inspection.
- Review proposed plans before editing.
- Review diffs before committing.
- Keep secrets in ignored files.
- Use test branches.
- Avoid auto-approval for risky commands.
- Do not let agents modify deployment credentials without review.

## AI output review checklist

Use this before accepting output:

- Does the answer match the logs and facts?
- Did it cite or reference the right source?
- Did it invent a version, feature, or behavior?
- Are commands safe to run?
- Are secrets removed?
- Is there a rollback path?
- Does a human need to approve the next action?
