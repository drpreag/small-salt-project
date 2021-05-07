# Revoke any users with a role of revoked

{% for user, args in pillar.get('revokedusers', {}).items() %}

{{user}}:
  user.absent: []
  group.absent: []

{% endfor %}

