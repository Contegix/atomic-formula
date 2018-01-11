{% from "atomic/map.jinja" import atomic with context %}


{% if grains['os_family'] == "RedHat" %}

install_pubkey_atomic_art:
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt
    - source: salt://atomic/files/RPM-GPG-KEY.art.txt

install_pubkey_atomic:
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY.atomicorp.txt
    - source: salt://atomic/files/RPM-GPG-KEY.atomicorp.txt

atomic-repo-{{ atomic.dist }}:
 pkgrepo.managed:
    - humanname: atomic
    - mirrorlist: {{ atomic.repo }}
    - gpgcheck: 1
    - gpgkey: >
        file:///etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt 
        file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atomicorp.txt
    - require:
      - file: install_pubkey_atomic_art
      - file: install_pubkey_atomic

{% elif grains['os_family'] == "Debian" %}
atomic-repo-{{ atomic.dist }}:
 pkgrepo.managed:
    - humanname: {{ atomic.dist }}
    - name: {{ atomic.repo }}
    - gpgcheck: 1
    - gpgkey: {{ atomic.gpgkey }}
{% endif %}
