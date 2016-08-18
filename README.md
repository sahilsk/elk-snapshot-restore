Instructions
-------

## Pre-requisites

- your workstation should have ansible installed
    - http://docs.ansible.com/ansible/intro_installation.html#latest-releases-via-apt-ubuntu
- your workstation should be aws configured
    - AWS Secrets to launch instance
- AWS Secrets to access and download backukp index
    - security group with enough ports opened
    - keypair, subnet id to use

## Edit Vagrantfile 

- put above asked information in vagrantfile
- Also mention how much GB space is required on server. Default: 50GB

## Edit playbook.yml file

- put index list to restore
- put s3 creds used to pull them from aws

```
---
- hosts: all
  gather_facts: yes
  roles:
   - elk_restore
  sudo: true
  vars:
    - indexes:
        - 'logstash-2016.03.17'
        - 'logstash-2015.09.30'
        - <add more indexes here >
    - s3_aws_access_key: '<aws creds>'
    - s3_aws_secret_key: '<aws creds>'
```


## how-to

Fire up vagrant
    
    vagrant up

- It will launch aws instance
- setup elasticsearch and kibana
- pull indices from s3 buckets
- restore them to elasticsearch


If vagrant up failed somewhere, then run provisioning only

    vagrant provision

After every thing is done, simply delete the instance

    vagrant destroy


References
------

- https://www.vagrantup.com/docs/provisioning/ansible_intro.html
