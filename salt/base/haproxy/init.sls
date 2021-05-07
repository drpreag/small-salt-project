haproxy:
  pkg:
    - installed
  service.running:
    - enable: True
    - watch:
      - pkg: haproxy
      - file: /etc/haproxy/haproxy.cfg
      - file: /etc/default/haproxy
    - require:
      - user: haproxy

/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://haproxy/templates/etc_haproxy_haproxy_cfg.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644

/etc/default/haproxy:
  file.managed:
    - source: salt://haproxy/templates/etc_default_haproxy
    - user: root
    - group: root
    - mode: 644

