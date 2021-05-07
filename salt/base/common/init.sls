# /srv/salt/base/common/init.sls

# dig is in dnsutils on .deb
{% if grains['os'] in [ 'Ubuntu', 'Debian' ] %}
dnsutils:
  pkg.installed:
    - version: 'latest'
{% endif %}

# dig is in bind-utils on .rpm
{% if grains['os'] in [ 'Amazon', 'CentOS' ] %}
bind-utils:
  pkg.installed:
    - version: 'latest'
{% endif %}

net-tools:
  pkg.installed:
    - version: 'latest'

mc:
  pkg.installed:
    - version: 'latest'

htop:
  pkg.installed:
    - version: 'latest'

nano:
  pkg.installed:
    - version: 'latest'

