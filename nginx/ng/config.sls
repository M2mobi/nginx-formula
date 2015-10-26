# nginx.ng.config
#
# Manages the main nginx server configuration file.

{% from 'nginx/ng/map.jinja' import nginx, sls_block with context %}

{% if nginx.install_from_source %}
nginx_log_dir:
  file.directory:
    - name: /var/log/nginx
    - user: {{ nginx.server.config.user }}
    - group: {{ nginx.server.config.user }}
{% endif %}

nginx_config:
  file.managed:
    {{ sls_block(nginx.server.opts) }}
    - name: {{ nginx.lookup.conf_file }}
    - source: salt://nginx/ng/files/nginx.conf
    - template: jinja
    - context:
        config: {{ nginx.server.config|json() }}

nginx_fastcgi:
  file.managed:
    - name: /etc/nginx/fastcgi_params
    - source: salt://nginx/ng/files/fastcgi_params

nginx_rewrite_lunr:
  file.managed:
    - name: /etc/nginx/rewrite_lunr
    - source: salt://nginx/ng/files/rewrite_lunr
