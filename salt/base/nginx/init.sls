nginx:
  pkg:
    - installed
  service.running:
    - watch:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/templates/etc_nginx_nginx.conf
    - user: root
    - group: root
    - mode: 640

/etc/nginx/sites-available:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 664
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 664
    - require:
      - pkg: nginx

/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://nginx/templates/etc_nginx_sites_available_default.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - require:
      - file: /etc/nginx/sites-available

/etc/nginx/sites-enabled/default:
  file.symlink:
    - target: /etc/nginx/sites-available/default
    - require:
      - file: /etc/nginx/sites-available/default

/usr/share/nginx/html/index.html:
  file.managed:
    - source: salt://nginx/templates/usr_share_nginx_html_index_html.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644


