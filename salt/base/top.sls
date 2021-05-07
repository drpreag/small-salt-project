# /srv/pillar/base/top.sls

base:
  '*':
    - users
    - common

  'role:core':
    - match: grain
    - users.core
    - nginx

  'role:lb':
    - match: grain
    - users.lb
