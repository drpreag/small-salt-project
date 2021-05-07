# /srv/salt/base/users/admins.sls

{% for user, args in salt['pillar.get']('adminusers', {}).items() %}
{{ user }}:

{% if grains['os'] in ['Ubuntu', 'Debian'] %}
  group.present:
    - gid: {{ args['uid'] }}
{% endif %}

  user.present:
    - uid: {{ args['uid'] }}
    - groups:
      - {{ user }}
    - shell: {{ args['shell'] }}
    - home: /home/{{user}}
    {% if grains['os'] in ['Ubuntu', 'Debian'] %}
    - require:
      - group: {{ user }}
    - groups:
      - sudo
    {% endif %}
    {% if grains['os'] in ['Amazon', 'CentOS'] %}
    - groups:
      - wheel
    {% endif %}

/home/{{ user }}/.ssh:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - dir_mode: 700
    - require:
      - user: {{ user }}

{% if 'ssh-key' in args %}
{% if args['ssh-key'] == True %}
{{ user }}_key:
  ssh_auth.present:
    - user: {{ user }}
    - source: salt://users/ssh_keys/{{ user }}.pub
    - config: '%h/.ssh/authorized_keys'
{% endif %}
{% endif %}

{% endfor %}

