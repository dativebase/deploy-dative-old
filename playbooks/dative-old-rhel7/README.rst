===============================================================================
  Dative/OLD Deploy Playbook
===============================================================================

This Vagrant/Ansible provisioner installs, configures and serves Dative and the
OLD on a local vagrant virtual machine. It can be used to easily set up a local
development environment for working on Dative/OLD. With modification, it could
be used to configure and serve Dative and OLD instances on a single server.


Requirements
===============================================================================

- Vagrant_ 1.7 or newer::

    $ vagrant -v
    Vagrant 1.8.4

- Ansible_ 2.1.1.0 or newer::

    $ ansible --version
    ansible 2.3.0.0


Usage: create a development environment
===============================================================================

Follow these steps to set up a local Dative/OLD development environment in a
vagrant virtual machine (VM).

Provision the Dative/OLD VM
--------------------------------------------------------------------------------

First move to the dative-old playbook directory and then download the Ansible
roles from GitHub into the roles/ directory. These are Ansible playbooks that
perform distinct tasks, like installing MySQL or the OLD::

    $ cd deploy-dative-old/playbooks/dative-old
    $ ansible-galaxy install -f -p roles/ -r requirements.yml

Then use Vagrant to bring up (create) the virtual machine, which will trigger
its provisioning via Ansible::

    $ vagrant up

Use the following command to provision the VM. Note that the first time you run
``vagrant up`` the VM should be provisioned automatically and the following
command will not be required::

    $ vagrant provision

Provisioning will take a long time (about 10 minutes). If successful, it should
end with something like the following::

    PLAY RECAP *********************************************************************
    dative-old-local           : ok=84   changed=31   unreachable=0    failed=0

Successful provisioning means that the source code for OLD and Dative has been
installed, the system dependencies for the OLD have been installed (e.g.,
Ffmpeg, foma, TGrep2, MITLM), and two OLD instances and a Dative instance are
being served. The IP address of the server should be ``192.169.169.192`` or
whatever is the value of ``dative-old-local.ip`` in
deploy-dative-old/playbooks/dative-old/Vagrantfile. If you are using the
default configuration, the following applications should be live at the
following URLs:

- Dative at http://192.169.169.192:8000
- OLD instance #1 at http://192.169.169.192/testold/
- OLD instance #2 at http://192.169.169.192/testold2/

If you navigate to the Dative URL, you should see the Dative graphical user
interface (GUI). If you navigate to either of the OLD URLs, you will see a
large JSON object describing the OLD API.


Access the OLDs from Dative
--------------------------------------------------------------------------------

To access the OLD from the Dative, navigate to the Dative URL, click "Dative"
in the top menu bar and then "Application Settings"; then click the large
"Servers" button. If there is not yet a server for OLD instance #1, create it
by clicking the "+" button (with tooltip "create a new server") and give it a
name like "OLD instance #1" and set its URL to
"http://192.169.169.192/testold/".

You should now be able to log in to OLD instance #1 from Dative. Click on the
"login" button that looks like a lock in the top righthand corner. In the
"Server" field of the login dialog, choose "OLD instance #1" and login with
username "admin" and password "adminA_1". This is the default username and
password for the OLD administrator user, as defined in the source at
deploy-dative-old/playbooks/dative-old/old/old/models/modelbuilders.py.


SSH access to the VM
--------------------------------------------------------------------------------

To gain SSH access to the VM, run::

    $ vagrant ssh
    vagrant@dative-old-local:~$

To see that Ffmpeg, foma and MITLM are installed, run the following::

    vagrant@dative-old-local:~$ ffmpeg -help
    vagrant@dative-old-local:~$ foma -h
    vagrant@dative-old-local:~$ estimate-ngram -h

To re-provision by only running tasks with specific tags, e.g., the ``dative``
tag, run::

    $ env ANSIBLE_ARGS="--tags=dative" vagrant provision


Configuration
===============================================================================

This section explains how the files under
deploy-dative-old/playbooks/dative-old/ configure how Vagrant and Ansible
create the virtual machine.


Vagrantfile
--------------------------------------------------------------------------------

This is Vagrant's configuration file. It defines the OS and IP of the VM, as
well as the Ansible playbook (singlenode.yml)


vars-singlenode.yml
--------------------------------------------------------------------------------

This file defines variables that control the deployment. In particular, modify
``old_instances`` to control how many OLD instances are to be created.


singlenode.yml
--------------------------------------------------------------------------------

This is the root task. It pulls in variables from vars-singlenode.yml, performs
some tasks (like installing developer tools on the VM) and then executes the
roles described below.


requirements.yml
--------------------------------------------------------------------------------

Lists the roles, their URLs, names and git branches (versions). These roles are
Ansible playbooks that are downloaded to under roles/ when the
``ansible-galaxy install -f -p roles/ -r requirements.yml`` command is run.


roles/percona/
--------------------------------------------------------------------------------

This installs Percona (MySQL).


roles/old-src/
--------------------------------------------------------------------------------

Installs the `Online Linguistic Database (OLD)`_ as well as optionally also its
OS dependencies like Ffmpeg, foma and MITLM.


roles/dative-src/
--------------------------------------------------------------------------------

Installs and builds Dative_ using grunt.

roles/nginx/
--------------------------------------------------------------------------------

Uses Nginx to seve Dative and the OLD instances.



.. _Vagrant: https://www.vagrantup.com/docs/installation/
.. _Ansible: http://docs.ansible.com/ansible/latest/intro_installation.html
.. _`Online Linguistic Database (OLD)`: https://github.com/dativebase/old-pyramid
.. _Dative: https://github.com/dativebase/dative
