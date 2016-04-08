# nginx.config
#
# Manages the main nginx server configuration file.

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ '/map.jinja' import nginx, sls_block with context %}
{%- from tplroot ~ '/libtofs.jinja' import files_switch with context %}

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
    - source:
{% if 'source_path' in nginx.server.config %}
      - {{ nginx.server.config.source_path }}
{% endif %}
      {{ files_switch(['nginx.conf'],
                      'nginx_config_file_managed'
          )
      }}
    - template: jinja
{% if 'source_path' not in nginx.server.config %}
    - context:
        config: {{ nginx.server.config|json(sort_keys=False) }}
{% endif %}

nginx_fastcgi:
  file.managed:
    - name: /etc/nginx/fastcgi_params
    - source: salt://nginx/files/default/fastcgi_params

nginx_rewrite_lunr:
  file.managed:
    - name: /etc/nginx/rewrite_lunr
    - source: salt://nginx/files/default/rewrite_lunr

nginx_php:
  file.managed:
    - name: /etc/nginx/php.conf
    - source: salt://nginx/files/default/php.conf

{% if salt['grains.get']('ec2:account_id', '') == '069214163847' and salt['grains.get']('ec2_tags:role', '') == 'webserver' %}
nginx_rewrite_m2mobi:
  file.managed:
    - name: /etc/nginx/rewrite_m2mobi
    - source: salt://nginx/files/default/rewrite_m2mobi
{% endif %}

nginx_default_config:
  file.managed:
    - name: /etc/nginx/conf.d/default.conf.disabled
    - source: salt://nginx/files/default/default.conf

nginx_remove_default_config:
  file.absent:
    - name: /etc/nginx/conf.d/default.conf