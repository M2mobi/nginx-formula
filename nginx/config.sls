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

{% if 'htpasswd' in nginx %}
{{nginx.lookup.htpasswd_package}}:
  pkg.installed

{% for user,password in nginx.htpasswd.items() %}
{{user}}_in_htpasswd:
  webutil.user_exists:
    - name: {{user}}
    - password: {{password}}
    - htpasswd_file: /etc/nginx/htpasswd
    - force: true
{% endfor %}
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
    - source: salt://nginx/ng/files/fastcgi_params
    - template: jinja
    - context:
        config: {{ nginx.server.fastcgi|json() }}

nginx_rewrite_lunr:
  file.managed:
    - name: /etc/nginx/rewrite_lunr
    - source: salt://nginx/files/default/rewrite_lunr

nginx_rewrite_lunr_api:
  file.managed:
    - name: /etc/nginx/rewrite_lunr_api
    - source: salt://nginx/ng/files/rewrite_lunr_api

nginx_php:
  file.managed:
    - name: /etc/nginx/php.conf
    - source: salt://nginx/files/default/php.conf

nginx_rewrite_m2mobi:
  file.managed:
    - name: /etc/nginx/rewrite_m2mobi
    - source: salt://nginx/files/default/rewrite_m2mobi

nginx_default_config:
  file.managed:
    - name: /etc/nginx/conf.d/default.conf
    - source: salt://nginx/files/default/default.conf
