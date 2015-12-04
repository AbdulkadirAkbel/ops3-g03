install-windowsfeature web-server
get-service | ConvertTo-html -Property name,status | out-file C:\inetpub\wwwroot\index.html
start iexplore http://127.0.0.1