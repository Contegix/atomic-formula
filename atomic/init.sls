{% from "atomic/map.jinja" import atomic with context %}


{% if grains['os_family'] == "RedHat" %}
atomic-repo-{{ atomic.dist }}:
 pkgrepo.managed:
    - humanname: {{ atomic.dist }}
    - mirrorlist: {{ atomic.repo }}
    - gpgcheck: 1
    - gpgkey: {{ atomic.gpgkey }}

{% elif grains['os_family'] == "Debian" %}
atomic-repo-{{ atomic.dist }}:
 pkgrepo.managed:
    - humanname: {{ atomic.dist }}
    - name: {{ atomic.repo }}
    - gpgcheck: 1
    - gpgkey: {{ atomic.gpgkey }}
{% endif %}
