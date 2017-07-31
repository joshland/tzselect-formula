{% set tzsetting = salt['pillar.get']('timezone', {}).get('environment', 'US/Pacific') %}

/etc/systemd/system.conf.d:
  file.directory:
    - user:  root
    - group: root
    - mode: '0755'

/etc/systemd/system.conf.d/10-default-env.conf:
  file.managed:
    - user:  root
    - group: root
    - mode: '0440'
    - contents: |
        ### managed by salt [tzselect.sls]
        [Manager]
        DefaultEnvironment=TZ='{{ tzsetting }}'

/etc/profile.d/tzselect.systemd:
  file.managed:
    - user:  root
    - group: root
    - mode: '0440'
    - contents: |
        TZ='{{ tzsetting }}'      

/etc/profile.d/tzset.sh:
  file.managed:
    - user:  root
    - group: root
    - mode: '0644'
    - contents: |
        ### managed by salt [tzselect.sls]
        export TZ='{{ tzsetting }}'
