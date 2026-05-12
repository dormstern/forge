# Case study — segspec

[github.com/dormstern/segspec](https://github.com/dormstern/segspec) — a Go CLI that extracts network dependencies from app configs and emits Kubernetes NetworkPolicies. Built by the author of Forge in 2026 using the same framework that became this plugin.

**The velocity case.** Single developer, weekend prototype to shipped tool with awesome-list inclusion in 8 weeks of part-time work.

## The shape of the product

- **Single static Go binary.** `go install github.com/dormstern/segspec@latest` and you're done.
- **Static analysis only.** No runtime, no agents, no observation period. Reads Spring, Docker Compose, K8s manifests, Helm, .env, Maven/Gradle.
- **Provenance per dependency.** Every output is traced to the exact config line that declared it.
- **Demo target:** Sentry's self-hosted (70+ services). 411 dependencies extracted in 11ms.

## What Forge contributed

The framework didn't write segspec's code — it shaped *which features made it in*.

### v0.1 — provenance was promoted to the wedge

Initial scope had `evidence-format` (per-line provenance) as one of 4 features, treated as "documentation." A Devil's Advocate pass against the v0.1 plan flagged Cope Moat: *"static analysis isn't a moat — Calico ships a recommender too. What's the differentiation?"*

The answer surfaced in the same DA pass: **provenance.** Calico tells you what to allow; segspec tells you why. The team rewrote the v0.1 thesis to lead with provenance, and the demo (`segspec analyze sentry-self-hosted --format evidence`) became the README hook.

### NEVER list rejected two seductive features

The IDENTITY.md NEVER list said:
- Become an "AI guesses your dependencies" product
- Require runtime instrumentation

Both `ai-suggestion-mode` and `runtime-collection-helper` were proposed in cycle 1. Both went on the kill list because of NEVER violations. Without the framework's discipline, both would have shipped — and segspec would have been just another AI tool, not a deterministic-static-analysis tool.

### 10% Delete Rule fired in every cycle

By cycle 3, kill-list candidates included an experimental "graph visualization" that nobody used and a JSON-output-mode-v1 that was superseded by v2. Both removed cleanly via `type: "removal"` features. The repo stayed lean.

### Drift detector caught a marketing-vs-product split

In cycle 2, a feature called "honeycomb-comparison" landed in BUILD. The drift detector flagged it as DRIFT — it didn't serve WHO directly. The fix wasn't to kill the feature; it was to reclassify it as `type: "infrastructure"` (marketing infrastructure, not product feature). It still shipped, but the framework caught the categorization slip — and that pattern saved future cycles from confusion.

## Outcomes

- **Total elapsed:** 8 weeks of part-time work, single developer.
- **Forges run:** 3 PM cycles, contract_mode: "none" (single CLI binary, no public API surface).
- **Avg quality score across releases:** 8.4.
- **Awesome-lists earned:**
  - [magnologan/awesome-k8s-security](https://github.com/magnologan/awesome-k8s-security) (~3K stars)
  - [myugan/awesome-cicd-security](https://github.com/myugan/awesome-cicd-security)
  - [kai5263499/awesome-container-security](https://github.com/kai5263499/awesome-container-security)
  - [veggiemonk/awesome-docker](https://github.com/veggiemonk/awesome-docker) (35.9K stars)
  - [rootsongjc/awesome-cloud-native](https://github.com/rootsongjc/awesome-cloud-native)
- **Show HN posted:** Feb 2026.

## The transferable lesson

segspec is the case for "Forge works on small projects." The framework's overhead — 6 state files, 4 phases, drift checks — felt heavy for a CLI. But the framework's discipline — kill list, NEVER enforcement, Devil's Advocate before every plan — was *exactly* what kept a part-time project from accumulating drag.

Most weekend prototypes die because their owners can't decide what to *not* ship next. segspec didn't, because the 10% Delete Rule made the decision for it every release.

## See also

- [Example 03 — segspec, cycle zero](../../examples/03-segspec-cycle-zero/README.md) — full walkthrough with state-file snippets
- The segspec [README](https://github.com/dormstern/segspec/blob/main/README.md) — voice and structure template that informed Forge's own README
