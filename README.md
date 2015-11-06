# ansible-cassandra-deployment

Ansible roles for deploying (DSE) Cassandra, DataStax OpsCenter, and c*-stress load generators for automated performance testing.

DataStax OpsCenter is installed via yum, and then Cassandra is deployed via the OpsCenter API.   Some OS parameters are tweaked for higher performance.

## Configuration

Create ansible inventory file (`hosts`)

    [opscenter]
    host1
    [cassandra]
    host2
    host3
    host4
    [loadgen]
    host5
    host6

Alternatively, use [cobbler.py](http://docs.ansible.com/ansible/intro_dynamic_inventory.html#example-the-cobbler-external-inventory-script) to link to your cobbler deployment, and create opscenter, cassandra, and loadgen profiles.  Symlink cobbler.py to hosts.

Create `group_vars/all`

    httpproxy: http://proxy.example.com:8080
    dse_repo_un: some.username
    dse_repo_pw: some.password
    machine_un: root
    machine_pw: password
    cassandra_ver: apache c* ver for load generators

In `roles/opscenter/templates/provision.j2`, edit node information to match your environment *(TODO: have Ansible do this)*

    "node_information": [
        {
            "public_ip": "x.x.x.x",
            "private_ip": "x.x.x.x",
            "node_type": "cassandra"
        }
    ],

and edit accepted_fingerprints *(TODO: have Ansible do this)*

    "accepted_fingerprints": {
        "x.x.x.x": "ssh:fingerprint"
    }

Get ssh fingerprints like this:

    ssh-keyscan -p 22 -t rsa $IP > /tmp/key.pub 2> /dev/null && ssh-keygen -lf /tmp/key.pub | cut -f 2 -d ' '

## Running
    ansible-playbook site.yml

## Todo
- [ ] Better provision.yaml templating
- [ ] Selectively apply cassandra setting changes based on machine type
- [ ] Integrate c*-stress scripts
- [ ] Increase idempotence, check if cluster already created
- [ ] Test larger clusters
