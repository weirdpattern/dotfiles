function Create-SqlServer {
  param(
    [String]$Password = "M3thodist@dm1n"
  )
  
  podman run -d `
    --name mssql `
    --hostname mssql `
    --restart unless-stopped `
    -p 1433:1433 `
    -e ACCEPT_EULA=Y `
    -e MSSQL_SA_PASSWORD=$Password `
    -v D:/data/mssql:/var/opt/mssql/data `
    mcr.microsoft.com/mssql/server:2019-latest
}

function Start-SqlServer {
  podman start mssql
}

function Stop-SqlServer {
  podman stop mssql
}

function Create-Solr {
  podman run -d `
    --name solr `
    --restart unless-stopped `
    -p 8983:8983 `
    -e SOLR_SSL_KEY_STORE=/opt/solr/server/certs/solr-ssl.keystore.pfx `
    -e SOLR_SSL_TRUST_STORE=/opt/solr/server/certs/solr-ssl.keystore.pfx `
    -e SOLR_SSL_KEY_STORE_PASSWORD=123SecureSolr! `
    -e SOLR_SSL_TRUST_STORE_PASSWORD=123SecureSolr! `
    -v D:/data/solr/var:/var/solr `
    -v D:/data/solr/certs:/opt/solr/server/certs `
    solr:8.8.2
}

function Start-Solr {
  podman start solr
}

function Stop-Solr {
  podman stop solr
}

function Create-Seq {
  podman run -d `
    --name seq `
    --restart unless-stopped `
    -p 4431:443 `
    -p 45341:45341 `
    -e ACCEPT_EULA=Y `
    -e SEQ_API_CANONICALURI=https://seq.houstonmethodist.org `
    -v D:/data/seq/seqinit:/seqinit `
    -v D:/data/seq:/data `
    datalust/seq:latest
}

function Start-Seq {
  podman start seq
}

function Stop-Seq {
  podman stop seq
}