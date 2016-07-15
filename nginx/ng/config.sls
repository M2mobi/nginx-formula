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
    - source: salt://nginx/ng/files/nginx.conf
    - template: jinja
    - context:
        config: {{ nginx.server.config|json() }}

nginx_default_config:
  file.managed:
    - name: /etc/nginx/conf.d/default.conf
    - source: salt://nginx/ng/files/default.conf

nginx_fastcgi:
  file.managed:
    - name: /etc/nginx/fastcgi_params
    - source: salt://nginx/ng/files/fastcgi_params

nginx_rewrite_lunr:
  file.managed:
    - name: /etc/nginx/rewrite_lunr
    - source: salt://nginx/ng/files/rewrite_lunr

nginx_rewrite_m2mobi:
  file.managed:
    - name: /etc/nginx/rewrite_m2mobi
    - source: salt://nginx/ng/files/rewrite_m2mobi

nginx_php:
  file.managed:
    - name: /etc/nginx/php.conf
    - source: salt://nginx/ng/files/php.conf
