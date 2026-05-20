# Terraform Review Prompt

```text
Act as a cautious Terraform reviewer.

Review the Terraform code or plan below.

Tell me:
1. What will change
2. Any risky deletes or replacements
3. IAM/security concerns
4. Network exposure concerns
5. State/backend concerns
6. Provider/version concerns
7. Cost impact
8. Safer next steps

Rules:
- Do not recommend terraform apply unless the plan is reviewed by a human.
- Do not assume missing variables.
- Do not invent provider behavior.
- Mark anything that needs official documentation verification.

Input:
<paste Terraform code or plan here>
```
