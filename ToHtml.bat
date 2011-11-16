rmdir /s/q output
mkdir output
Pandoc\bin\pandoc.exe --from markdown --to html -o output\spec.html *.markdown
rem pause
