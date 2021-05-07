# /srv/salt/base/users/core.sls

{#  for user, args in salt['pillar.get']('coreusers', {}).items() #}
{% for user, args in pillar.get('coreusers', {}).items() %}
{{ user }}:
  group.present:
    - gid: {{ args['uid'] }}

  user.present:
    - uid: {{ args['uid'] }}
    - groups:
      - {{ user }}
    - shell: {{ args['shell'] }}
    - home: /home/{{user}}
    - require:
      - group: {{ user }}

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

