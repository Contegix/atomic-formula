{% from "atomic/map.jinja" import atomic with context %}

{% set test_cmd = {
    'RedHat': 'test -e /etc/yum.repos.d/atomic.repo',
    'Debian': 'test -e /etc/apt/sources.list.d/atomic.list',
}.get(grains.os_family) %}

run_installer:
 cmd.script:
    - source: salt://atomic/files/installer.sh
    - env:
      - NON_INT: 1
    - unless: "{{ test_cmd }}"
