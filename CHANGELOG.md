# Changelog

All notable changes to Forge will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-04-28

### Added
- Initial release. Three filters every release runs through — Devil's Advocate, 10% Delete Rule, drift checks every 5 features — then the Ralph Loop ships what survived.
- Two operating modes: Founder (`SCOUT → INTERROGATE → SYNTHESIZE → TEST`) and PM (`HARVEST → SHAPE → BUILD → SHIP`).
- 13 slash commands: `/forge:init`, `/forge:cycle`, `/forge:scout`, `/forge:interrogate`, `/forge:synthesize`, `/forge:falsify`, `/forge:harvest`, `/forge:shape`, `/forge:build`, `/forge:ship`, `/forge:drift`, `/forge:status`, `/forge:graduate`.
- 9 specialized agents: market-scout, interview-architect, devils-advocate, thesis-synthesizer, orchestrator, drift-detector, feature-breakdown, test-writer, builder.
- 10 contextual skills covering identity-anchor, the 10% Delete Rule, drift-protection, autonomy tiers, stabilization triggers, evidence weighting, community mining, founder mode, PM mode, and the entry-point overview.
- 13 state-file templates auto-scaffolded into the user's project on `/forge:init`.
- SessionStart hook that injects identity context when state files are present.
- 5 worked examples and 2 case studies.
