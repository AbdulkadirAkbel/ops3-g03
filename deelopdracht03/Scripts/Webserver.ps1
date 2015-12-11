install-windowsfeature web-server
get-service | ConvertTo-html -Property name,status | out-file C:\inetpub\wwwroot\index.html
