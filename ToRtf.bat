rmdir /s/q output
mkdir output

Pandoc\bin\pandoc.exe --from markdown -o output\OData.rtf -s "OData.markdown"
Pandoc\bin\pandoc.exe --from markdown -o output\OData_Format_AtomPub.rtf "OData AtomPub Format.markdown"
Pandoc\bin\pandoc.exe --from markdown -o output\OData_Format_Batch.rtf "OData Batch Processing Format.markdown"
Pandoc\bin\pandoc.exe --from markdown -o output\OData_Format_Json.rtf "OData Json Format.markdown"
Pandoc\bin\pandoc.exe --from markdown -o output\OData_URI_Conventions.rtf "OData URI Conventions.markdown"

rem pause
