include:
  - .init

{% from "vault/map.jinja" import vault with context %}
{%- if vault.self_signed_cert.enabled %}
create_self_signed_cert:
  cmd.run:
    - name: salt-call --local tls.create_self_signed_cert
    - creates: 
      - /etc/pki/tls/certs/localhost.crt
      - /etc/pki/tls/certs/localhost.key

{% endif -%}

/etc/vault:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/etc/vault/config:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /etc/vault

/etc/vault/config/server.hcl:
  file.managed:
    - source: salt://vault/files/server.hcl.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /etc/vault/config

{%- if vault.service.type == 'systemd' %}
/etc/systemd/system/vault.service:
  file.managed:
    - source: salt://vault/files/vault_systemd.service.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require_in:
      - service: vault

{% elif vault.service.type == 'upstart' %}
/etc/init/vault.conf:
  file.managed:
    - source: salt://vault/files/vault_upstart.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - require_in:
      - service: vault
{% endif -%}

vault:
  service.running:
    - enable: True
    - require:
      {%- if vault.self_signed_cert.enabled %}
      - cmd: generate self signed SSL certs
      {% endif %}
      - file: /etc/vault/config/server.hcl
      - cmd: install vault
    - onchanges:
      - cmd: install vault
      - file: /etc/vault/config/server.hcl
      - cmd: generate self signed SSL certs
