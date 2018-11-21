SHELL=/usr/bin/env bash

TOP_LEVEL_DOMAIN_SNAKE_CASE:=$(subst .,_,$(TOP_LEVEL_DOMAIN))

ROOT_CA_SIGNING_KEY_FILE:=$(TOP_LEVEL_DOMAIN_SNAKE_CASE)_ca.key
ROOT_CA_CERTIFICATE_FILE:=$(TOP_LEVEL_DOMAIN_SNAKE_CASE)_ca.crt

DOMAIN_SIGNING_KEY_FILE:=$(TOP_LEVEL_DOMAIN_SNAKE_CASE).key
DOMAIN_SIGNING_REQUEST_FILE:=$(TOP_LEVEL_DOMAIN_SNAKE_CASE).csr
DOMAIN_CERTIFICATE_FILE=$(TOP_LEVEL_DOMAIN_SNAKE_CASE).crt

ifndef TOP_LEVEL_DOMAIN
$(error TOP_LEVEL_DOMAIN is not set)
endif

all:
	@echo 'usage: make <rule>'

certificates: $(DOMAIN_CERTIFICATE_FILE)

install: certificates
	sudo cp $(ROOT_CA_CERTIFICATE_FILE) /usr/local/share/ca-certificates
	sudo update-ca-certificates
	sudo cp $(DOMAIN_SIGNING_KEY_FILE) /etc/ssl/private
	sudo cp $(DOMAIN_CERTIFICATE_FILE) /etc/ssl/certs

$(ROOT_CA_SIGNING_KEY_FILE):
	openssl genrsa -out $@ 2048

$(ROOT_CA_CERTIFICATE_FILE): $(ROOT_CA_SIGNING_KEY_FILE)
	openssl req \
	  -new \
	  -x509 \
	  -days 365 \
	  -key $< \
	  -subj "/C=CN/ST=GD/L=SZ/O=$(TOP_LEVEL_DOMAIN)/CN=$(TOP_LEVEL_DOMAIN) Root CA" \
	  -out $@

$(DOMAIN_SIGNING_KEY_FILE) $(DOMAIN_SIGNING_REQUEST_FILE):
	openssl req \
	  -newkey rsa:2048 \
	  -nodes \
	  -keyout $(DOMAIN_SIGNING_KEY_FILE) \
	  -subj "/C=CN/ST=GD/L=SZ/O=$(TOP_LEVEL_DOMAIN)/CN=*.$(TOP_LEVEL_DOMAIN)" \
	  -out $(DOMAIN_SIGNING_REQUEST_FILE)

$(DOMAIN_CERTIFICATE_FILE): $(ROOT_CA_SIGNING_KEY_FILE) $(ROOT_CA_CERTIFICATE_FILE) $(DOMAIN_SIGNING_REQUEST_FILE)
	openssl x509 \
	  -req \
	  -extfile <(printf "subjectAltName=DNS:$(TOP_LEVEL_DOMAIN),DNS:*.$(TOP_LEVEL_DOMAIN)") \
	  -days 365 \
	  -in $(DOMAIN_SIGNING_REQUEST_FILE) \
	  -CA $(ROOT_CA_CERTIFICATE_FILE) \
	  -CAkey $(ROOT_CA_SIGNING_KEY_FILE) \
	  -CAcreateserial \
	  -out $@
	rm $(DOMAIN_SIGNING_REQUEST_FILE)
