rmdir /s/q output
mkdir output

Pandoc\bin\pandoc.exe --from markdown --to html -o output\OData.html "OData.markdown"
Pandoc\bin\pandoc.exe --from markdown --to html -o output\OData_Format_AtomPub.html "OData AtomPub Format.markdown"
Pandoc\bin\pandoc.exe --from markdown --to html -o output\OData_Format_Batch.html "OData Batch Processing Format.markdown"
Pandoc\bin\pandoc.exe --from markdown --to html -o output\OData_Format_Json.html "OData Json Format.markdown"
Pandoc\bin\pandoc.exe --from markdown --to html -o output\OData_URI_Conventions.html "OData URI Conventions.markdown"

rem pause
