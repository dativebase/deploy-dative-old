===============================================================================
  Dative/OLD Deploy Playbook
===============================================================================

This Vagrant/Ansible provisioner installs, configures and serves Dative and the
OLD on a local vagrant virtual machine.


Requirements
===============================================================================

- Vagrant 1.7 or newer
- Ansible 2.0 or newer


Usage
===============================================================================

1. Download the Ansible roles from GitHub into roles/. (These are potentially
   reusable Ansible playbooks that perform distinct tasks, like installing
   MySQL or the OLD)::

    $ ansible-galaxy install -f -p roles/ -r requirements.yml

2. Use Vagrant to create the virtual machine, which will trigger its
   provisioning via Ansible::

    $ vagrant up

3. To ssh to the VM, run::

    $ vagrant ssh

4. To (re-)provision the VM (e.g., after code changes), run::

    $ vagrant provision


Configuration
===============================================================================

Tweak vars in vars-singlenode.yml. In particular, modify `old_instances` to
control the OLD instances that are created.
