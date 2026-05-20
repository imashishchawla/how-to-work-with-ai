# Local LLM Security Checklist

- [ ] Endpoint is bound to localhost unless LAN access is required.
- [ ] Firewall rules are reviewed.
- [ ] No public exposure of local model API.
- [ ] No real secrets used in prompts.
- [ ] Test data is sanitized.
- [ ] Downloaded models come from trusted sources.
- [ ] Tool and model versions are documented.
- [ ] Access logs are reviewed if running as a shared service.
