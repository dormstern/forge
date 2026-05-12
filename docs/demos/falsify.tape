# VHS tape — `/forge:falsify` standalone Devil's Advocate
# Pre-req: docs/demos/fixtures/falsify.txt
# Run from repo root: vhs docs/demos/falsify.tape

Output docs/demos/falsify-demo.gif

Set Shell zsh
Set FontSize 15
Set Width 1000
Set Height 700
Set Theme "Catppuccin Mocha"
Set TypingSpeed 35ms
Set Padding 20

Hide
Type "setopt INTERACTIVE_COMMENTS"
Enter
Type "function /forge:falsify { cat docs/demos/fixtures/falsify.txt }"
Enter
Type "clear"
Enter
Show
Sleep 600ms

Type "# Paste any plan, pitch, PRD, or thesis."
Enter
Type "# Devil's Advocate runs 8 attack vectors + pre-mortem."
Enter
Sleep 1800ms

Type "/forge:falsify acqui-hire-pitch.md"
Enter
Sleep 6s
