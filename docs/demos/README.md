# Demo GIFs

Three demos, three .tape sources, three rendered .gif outputs.

## Render

Install [vhs](https://github.com/charmbracelet/vhs):

```bash
brew install vhs
```

Render all three:

```bash
vhs docs/demos/shape.tape
vhs docs/demos/falsify.tape
vhs docs/demos/drift.tape
```

The output GIFs land at `docs/demos/{shape,falsify,drift}-demo.gif`. The README references those paths.

## Why .tape, not raw GIFs

Rendered GIFs are large binary blobs that don't diff well in git. The .tape files are 2KB each, version-controlled, and re-render deterministically — change the script, run vhs, get a fresh GIF.

This is the same pattern segspec uses ([docs/demos/](https://github.com/dormstern/segspec/tree/main/docs/demos)).
