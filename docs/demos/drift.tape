# VHS tape — `/forge:drift` audit demo
# Pre-req: docs/demos/fixtures/drift.txt
# Run from repo root: vhs docs/demos/drift.tape

Output docs/demos/drift-demo.gif

Set Shell zsh
Set FontSize 15
Set Width 1000
Set Height 600
Set Theme "Catppuccin Mocha"
Set TypingSpeed 35ms
Set Padding 20

Hide
Type "setopt INTERACTIVE_COMMENTS"
Enter
Type "function /forge:drift { cat docs/demos/fixtures/drift.txt }"
Enter
Type "clear"
Enter
Show
Sleep 600ms

Type "# Auto-fires every 5 features during /build."
Enter
Type "# Audits identity, contracts, architecture, rework patterns."
Enter
Sleep 1800ms

Type "/forge:drift"
Enter
Sleep 6s
