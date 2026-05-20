# 02 - Key AI Terms Engineers Should Know

![Slide 4](../assets/slides/slide-04.png)

## Prompt

The instruction you give to the AI.

Good prompts include:

- Role
- Context
- Task
- Constraints
- Output format
- Review expectations

Example:

```text
Act as a senior Terraform support engineer. Review the log below and identify likely causes. Do not provide a final answer unless the log supports it.
```

## Context window

The amount of text the model can consider at once. Large context windows are useful for long logs, large code files, and documentation, but they do not guarantee better answers.

## Tokens

Models process text as tokens. Tokens are smaller pieces of words. More tokens usually means more cost, latency, and memory usage.

## Hallucination

A confident answer that is not supported by facts. This is why engineers must verify AI output.

## Embeddings

A way to convert text into numerical vectors so related content can be found by meaning, not just keyword matching.

## RAG

Retrieval Augmented Generation. The model first retrieves relevant documents, then answers using that context.

```mermaid
flowchart LR
    Q[User question] --> S[Search docs/KB/code]
    S --> C[Relevant context]
    C --> L[LLM answer]
    L --> V[Human review]
```

## Fine-tuning

Training a model further on specific examples. This can help with style or domain-specific behavior, but it is not always needed. Many engineering use cases work better with strong prompts and good retrieval.

## Tool calling

The model can call tools, such as search, terminal commands, APIs, or file readers. This makes agents powerful, but also risky without permission boundaries.

## Inference

Running the model to generate output.

## Agent

An AI system that can take actions, not just generate text. Agents use tools (terminal, file system, APIs, search) and can run multi-step tasks with minimal human input per step. Because agents can make changes, they require careful permission boundaries.

## System prompt

Instructions given to the model before the user's message. System prompts define the model's role, rules, tone, and output format. A well-written system prompt makes responses more consistent and safer.

## Temperature

A setting that controls how creative or predictable the model's output is. Lower values (0–0.3) produce more focused, repeatable answers. Higher values (0.7–1.0) produce more varied, creative output. For engineering tasks that need accurate, factual answers, use a low temperature.

## MCP

Model Context Protocol. A standard way for AI tools to connect to external tools and data sources. Use it carefully because it can expose files, repositories, or services to an AI agent.
