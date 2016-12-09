===============================================================================
  OLD/Dative Vagrant/Ansible Deploy Scripts
===============================================================================

This Vagrant/Ansible deploy set up does the following:

1. creates a Ubuntu 14.04 server,
2. installs the OLD and its Python/system dependencies
3. installs Dative
4. initializes/configures an OLD instance (database, tables, and directories)
5. serves the OLD instance (SSL/HTTPS, nginx)
6. serves Dative


Usage
===============================================================================

Donwload the Ansible roles. These install and configure MySQL (Percona), the
OLD, Dative and Nginx.::

    $ cd deploy-dative-old/playbooks/dative-old
    $ ansible-galaxy install -f -p roles/ -r requirements.yml

Create the virtual machine and provision it::

    $ vagrant up

To log in to the virtual machine::

    $ vagrant ssh

If you make changes to the code and want to re-provision the virtual machine
(via Ansible), run::

    $ vagrant provision
