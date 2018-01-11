{% from "atomic/map.jinja" import atomic with context %}


{% if grains['os_family'] == "RedHat" %}

install_pubkey_atomic:
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-ATOMIC
    - source: salt://atomic/files/RPM-GPG-KEY.atomicorp.txt

atomic-repo-{{ atomic.dist }}:
 pkgrepo.managed:
    - humanname: {{ atomic.dist }}
    - mirrorlist: {{ atomic.repo }}
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ATOMIC
    - require:
      - file: install_pubkey_atomic

{% elif grains['os_family'] == "Debian" %}
atomic-repo-{{ atomic.dist }}:
 pkgrepo.managed:
    - humanname: {{ atomic.dist }}
    - name: {{ atomic.repo }}
    - gpgcheck: 1
    - gpgkey: {{ atomic.gpgkey }}
{% endif %}
