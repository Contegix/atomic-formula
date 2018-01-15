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
 pkg.installed:
    - sources:
      - atomic-release: https://updates.atomicorp.com/channels/atomic/centos/6/x86_64/RPMS/atomic-release-1.0-21.el6.art.noarch.rpm
    - require:
      - file: install_pubkey_atomic_art
      - file: install_pubkey_atomic
    - unless: 'test -e /etc/yum.repos.d/atomic.repo'

{% elif grains['os_family'] == "Debian" %}
atomic-repo-{{ atomic.dist }}:
 pkgrepo.managed:
    - humanname: {{ atomic.dist }}
    - name: {{ atomic.repo }}
    - gpgcheck: 1
    - key_url: {{ atomic.gpgkey }}
{% endif %}
