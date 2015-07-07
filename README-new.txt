# Belarus Ruby User Group

Belarusian Ruby User Group - Ruby-developer community, created for the exchange of ideas and experiences. We are also interested in the development of Ruby in our country and help each other to build a successful IT-career.

## Development

To run application on your local:
You have to install virtual_box, vagrant and ansible.
Then go to railsbox/development 
and run
  vagrant up

You can 'vagrant ssh' into the virtual machine with the project for debugging purposes.

## Staging
It is the same as development but now ansible will not be part of vagrant config but will connect to 
virtual machine line any other pc in the network.

run:
 'vagrant up'   - to just run virtual machine
 '. provision.sh' - to set up all apps needed.
 '. deploy.sh' - to deploy app from the repository

please note, that you will have to run 
 'vagrant ssh' and then add your local machine ~/.ssh/id_rsa.pub key into virtual's ~/.ssh/authorized_keys file, to make ansible able to 
 ssh to the virtual machine without password.
If you experienced any errors with connection just try to run 'ssh vagrant@localhost -p2222' and see what the error is.

## Production.

1. Update file 'railsbox/production/inventory' and 'railsbox/ansible/group_vars/production/config.yml' with ip or domain name of the servers for the installation.
2. Add your local pc's id_rsa.pub file contents to the production servers authorized keys. For digital ocean you can do it in the admin panel.
3. Go to 'railsbox/production'
4. Run '. provision.sh' to install all necessary soft
5. Add contents of the file 'railsbox/ssh_keys/id_rsa.pub' to the deploy keys for the project repository in the hub (e.g. github).
6. Run '. deploy.sh' to deploy the app.


Note, it is recommended to manually restart the server (use ssh and sudo shutdown -r now) after first provisioning