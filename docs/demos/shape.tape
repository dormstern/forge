# VHS tape — `/forge:shape` hero demo
# Pre-req: docs/demos/fixtures/shape.txt
# Run from repo root: vhs docs/demos/shape.tape

Output docs/demos/shape-demo.gif

Set Shell zsh
Set FontSize 15
Set Width 1000
Set Height 700
Set Theme "Catppuccin Mocha"
Set TypingSpeed 35ms
Set Padding 20

# Pre-bind /forge:shape (zsh allows function names with /), then clear so only a clean prompt shows.
Hide
Type "setopt INTERACTIVE_COMMENTS"
Enter
Type "function /forge:shape { cat docs/demos/fixtures/shape.txt }"
Enter
Type "clear"
Enter
Show
Sleep 600ms

Type "# /forge:init has scaffolded state files. /forge:harvest collected 4 signals."
Enter
Sleep 1500ms

Type "/forge:shape"
Enter
Sleep 6s
