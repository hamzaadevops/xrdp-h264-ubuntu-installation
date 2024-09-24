# Install Salt on Ubuntu
**Step 1**: Add Repo Packge for Ubuntu
```bash
sudo curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/ubuntu/22.04/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg
echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] https://repo.saltproject.io/salt/py3/ubuntu/22.04/amd64/latest jammy main" | sudo tee /etc/apt/sources.list.d/salt.list
```
**Step 2**: Install on Master:
```bash
sudo apt-get update
sudo apt-get install salt-master
```
**Step 3**: Basic master configuration
```bash
sudo vi /etc/salt/master.d/network.conf
```
and paste this portion there:
``` code
# The network interface to bind to
interface: 192.0.2.20 #IP of Master

# The Request/Reply port
ret_port: 4506

# The port minions bind to for commands, aka the publish port
publish_port: 4505

# we can also configure worker threads
worker_threads: 5 #one thread can be used for 200 minions
```
**Step 4**: Install on Minion:
```bash
sudo apt-get update
sudo apt-get install salt-minion
```

**Step 5**: Basic minion configuration
```bash
sudo vi /etc/salt/minion.d/master.conf

# Paste this code there
master: 192.0.2.20 #IP of MASTER
id: rebel_1 #Any Name we want to give to this minion
```

**Step 6**: Start with systemctl
```bash
# On Master
systemctl start salt-master

# On Minion
systemctl start salt-minion
```
**Step 7**: Accepting Keys of Minions
- Call `salt-key` to see the current state of key management:
```bash
salt-key
```
- To accept a key run:
```bash
salt-key -a id_of_minion
```
- If there are multiple keys to accept and are trusted, you can accept all at once:
``` bash
salt-key -A
```

- To delete a key run:
```bash
salt-key -d id_of_minion
```
- If there are multiple keys to be deleted, you can delete all at once:
``` bash
salt-key -D

# deleting with a filter
salt-key -d 'web*'
```
## **Verify the Configuration**:
``` bash
salt '*' test.version
```
