rmdir /s/q output
mkdir output

multimarkdown\multimarkdown.exe -b -t odf *.markdown
move *.fodt output

rem pause
