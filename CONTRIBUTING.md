# Contributing to cycle

Contributions welcome. Open an issue first for anything non-trivial.

## Development setup

```bash
git clone https://github.com/dormstern/forge.git
cd cycle
```

The plugin is documentation-driven — there's no runtime code. To test changes locally:

1. Symlink (or clone) the repo into your Claude Code plugins directory:
   ```bash
   ln -s "$(pwd)" ~/.claude/plugins/cycle
   ```
2. Restart Claude Code.
3. Run `/forge:init` in a sandbox repo and exercise the cycle.

## Validator

The validator runs on every push and PR via GitHub Actions. Run it locally:

```bash
./scripts/validate-plugin.sh
```

It checks plugin.json + package.json + hooks.json validity, every command/agent/skill has frontmatter + description, README is under the 250-line cap, and the templates/ directories exist with content.

All checks must pass before merging.

## Where to add things

| Want to add… | Add it here |
|---|---|
| A new slash command | `commands/<name>.md` |
| A new specialized agent | `agents/<name>.md` |
| A new contextual skill | `skills/<slug>/SKILL.md` |
| A new state-file template | `templates/{pm,founder}/<file>` |
| A worked example | `examples/<NN>-<slug>/README.md` |
| A demo GIF | `docs/demos/<name>.tape` (vhs source) |

Every command and skill must have YAML frontmatter with at minimum `description:` (and `name:` for skills). Every agent must have `name:`, `description:`, `tools:`, `model:`.

## Voice

Match segspec / leashed: declarative, dry, em-dashes, anti-hype, short paragraphs, "what it does" before "why you should care." If a sentence sounds like marketing copy, cut it.

## Submitting changes

1. Branch from `main`.
2. Run the validator. All 77+ checks must pass.
3. Open a PR with a clear title and a one-paragraph description of *why* the change exists. The "why" matters more than the "what" for documentation-driven projects.
4. Tag `@dormstern` for review.

## License

By contributing, you agree your contributions are licensed under [MIT](LICENSE).
