# nginx.ng
#
# Meta-state to fully install nginx.

{% from 'nginx/ng/map.jinja' import nginx, sls_block with context %}

include:
  - nginx.ng.config
  - nginx.ng.service
  - nginx.ng.servers
  - nginx.ng.certificates

nginx_developers:
  module.run:
    - name: group.adduser
{% if salt['grains.get']('ec2_tags:role', 'bitbucket') == '' %}
    - m_name: stash
{% else %}
    - m_name: developers
{% endif %}
    - username: nginx

extend:
  nginx_service:
    service:
      - listen:
        - file: nginx_config
      - require:
        - file: nginx_config
  nginx_config:
    file:
      - require:
        {% if nginx.install_from_source %}
        - cmd: nginx_install
        {% else %}
        - pkg: nginx_install
        {% endif %}
