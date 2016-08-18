Instructions
-------

## Pre-requisites

- your workstation should have ansible installed
    - http://docs.ansible.com/ansible/intro_installation.html#latest-releases-via-apt-ubuntu
- your workstation should be aws configured
    - AWS Secrets to launch instance
    - security group with enough ports opened
    - keypair, subnet id to use
- AWS Secrets to download backukp index from s3 bucket

## Edit Vagrantfile 

- put above asked information in vagrantfile
- Also mention how much GB space is required on server. Default: 50GB
    - get idea from index size

## Create playbook.yml file

- copy **playbook.yml.sample** to **playbook.yml** and edit
    - put index list to restore
    - put s3 creds used to pull them from aws


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

Troubleshooting
------

- cluster health is red and shard unassigned

This is a common issue arising from the default index setting, in particularly,
when you try to replicate on a single node. To fix this with transient cluster
setting, do this:

        curl -XPUT http://localhost:9200/_settings -d '{ "number_of_replicas" :0 }'

Next, enable the cluster to reallocate shards (you can always turn this on after
all is said and done):

        curl -XPUT http://localhost:9200/_cluster/settings -d '
        {
                "transient" : {
                            "cluster.routing.allocation.enable": true
                                }
        }'

Now sit back and watch the cluster clean up the unassigned replica shards. If
you want this to take effect with future indices, don't forget to modify
elasticsearch.yml file with the following setting and bounce the cluster:

        index.number_of_replicas: 0

- check cluster health again

        curl -s -XGET 'http://localhost:9200/_cluster/health?pretty








References
------

- https://www.vagrantup.com/docs/provisioning/ansible_intro.html
- https://github.com/sahilsk/DevOp-Tools-and-Scripts/blob/master/Articles/elasticsearch/restore_snapshot.md
