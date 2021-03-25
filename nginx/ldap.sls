nginx_ldap_install:
  pkg.installed:
    - name: nginx-ldap-auth

nginx_ldap_service:
  service.running:
    - name: nginx-ldap-auth
    - enable: True
    - require:
      - pkg: nginx_ldap_install
