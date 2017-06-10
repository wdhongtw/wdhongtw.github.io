---
title: 製作 X.509 憑證
date: 2017-06-10 14:10:50
tags: [Server, Certificate, OpenSSL]
---

自己利用 OpenSSL 製作憑證的一點心得筆記。

內容尚待翻譯。

# Certificate

## Make the certificate using by http, smtp, imap, pop3

- Renew every 90 days.
- Usin PEM for all files, not DER.
- All pem file should put in `/etc/ssl/` folder.
  Like `/etc/ssh/web`

## Generate Private Key (done for once)

``` sh
openssl genrsa -out private.pem 2048
```

## Generate certificate request

Create `csr.config`

```
[req]
default_bits = 4096
prompt = no
default_md = sha256
distinguished_name = dn
req_extensions = req_ext

[ dn ]
C=TW
ST=Taiwan
L=Hsinchu
O=Bitisle
OU=Bitisle Admin
emailAddress=wdhongtw@gmail.com
CN = bitisle.net

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = bitisle.net
DNS.2 = www.bitisle.net
```

``` sh
openssl req -key private.pem -new -out request.pem -config csr.config
```

Use following command to check contents in request file.

``` sh
openssl req -in request.pem -text -noout
```

## Sign by Let's Encrypt via SSL For Free

-   [Let's Encrypt](https://letsencrypt.org/getting-started/)
-   [SSLForFree](https://www.sslforfree.com/)

Visite sslforfree.com, give them the request and get the certificate.

Save the certificate as `certificate.pem`

To check the content in certificate, use:

``` sh
openssl x509 -in certificate.pem -text -noout
```

