# Agent Permissions Checklist

- [ ] Agent starts in inspect-only mode.
- [ ] Agent cannot read secret files.
- [ ] Agent cannot run destructive commands without approval.
- [ ] Agent edits are limited to the project folder.
- [ ] Git diff is reviewed before commit.
- [ ] Tests are run after changes.
- [ ] Package install commands are reviewed.
- [ ] Deployment commands require manual approval.
