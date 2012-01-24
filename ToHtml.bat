rmdir /s/q output
mkdir output

multimarkdown\multimarkdown.exe -b -t html *.markdown
move *.html output


rem pause
