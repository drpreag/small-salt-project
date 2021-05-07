# /srv/pillar/base/top.sls

base:
  '*':
    - users

  'role:bastion':
    - match: grain
    - users.bastion

  'role:core':
    - match: grain
    - users.core
    #- nginx

  'role:lb':
    - match: grain
    - users.lb
