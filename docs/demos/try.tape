# VHS tape — `/forge:try` magic-moment demo
# Pre-req: docs/demos/fixtures/try.txt
# Run from repo root: vhs docs/demos/try.tape

Output docs/demos/try-demo.gif

Set Shell zsh
Set FontSize 14
Set Width 1100
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 35ms
Set Padding 20

Hide
Type "setopt INTERACTIVE_COMMENTS"
Enter
Type "function /forge:try { cat docs/demos/fixtures/try.txt }"
Enter
Type "clear"
Enter
Show
Sleep 600ms

Type "# Just installed Forge. Want to see what it does in 30 seconds?"
Enter
Sleep 1500ms

Type "/forge:try"
Enter
Sleep 8s
