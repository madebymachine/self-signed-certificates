# self-signed-certificates

Self-signed SSL certificate generation

## Prerequisites

- [GNU Make](https://www.gnu.org/software/make/)
- [OpenSSL](https://www.openssl.org/)

## Commands

- `TOP_LEVEL_DOMAIN=local.foo.com make certificates`  
  Generate a root CA certificate for `<TOP_LEVEL_DOMAIN>` and write it to
  `local_foo_com_ca.crt`, and generate a signing key and server certificate for
  both `<TOP_LEVEL_DOMAIN>` and `*.<TOP_LEVEL_DOMAIN>` and write them to
  `local_foo_com.key` and `local_foo_com.crt`, respectively.

- `make install`  
  Install the root CA certificate to `/usr/local/share/ca-certificates` and
  update `/etc/ssl/ca-certificates.crt`, and install the server signing key and
  certificate to `/etc/ssl/private` and `/etc/ssl/certs`, respectively.

<hr>

<p xmlns:dct="http://purl.org/dc/terms/">
  <a href="http://creativecommons.org/publicdomain/zero/1.0/" rel="license">
    <img
      alt="CC0"
      style="border-style: none;"
      src="http://i.creativecommons.org/p/zero/1.0/88x31.png"
    >
  </a>
  <br>
  To the extent possible under law,
  <span rel="dct:publisher" resource="[_:publisher]">
    the person who associated CC0
  </span>
  with this work has waived all copyright and related or neighboring rights to
  this work.
</p>
