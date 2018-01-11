{% from "atomic/map.jinja" import atomic with context %}


{% if grains['os_family'] == "RedHat" %}
atomic-repo-{{ atomic.dist }}:
 pkgrepo.managed:
    - humanname: {{ atomic.dist }}
    - mirrorlist: {{ atomic.repo }}
    - gpgcheck: 1
    - gpgkey: salt://atomic/files/RPM-GPG-KEY.atomicorp.txt

{% elif grains['os_family'] == "Debian" %}
atomic-repo-{{ atomic.dist }}:
 pkgrepo.managed:
    - humanname: {{ atomic.dist }}
    - name: {{ atomic.repo }}
    - gpgcheck: 1
    - gpgkey: salt://atomic/files/RPM-GPG-KEY.atomicorp.txt
{% endif %}
