rmdir /s/q output
mkdir output
Pandoc\bin\pandoc.exe --from markdown -o output\spec.rtf -s *.markdown
rem pause
