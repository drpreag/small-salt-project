haproxy:
  pkg.installed
    - version: '2'
  service:
    - running
    - require:
      - pkg: haproxy

/etc/haproxy/haproxy.conf:
  file.managed:
    - source: salt://templates/haproxy
    - mode: 644
    - user: root
    - group: root
