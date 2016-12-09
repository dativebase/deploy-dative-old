# Dative/OLD Playbook

## TODOs

1. Fork artefactual-labs ansible-percona
2. Fork artefactual-labs ansible-nginx
3. Create ansible-dative-src
4. Create ansible-old-src

Playbook that installs Dative and the OLD on a local vagrant virtual
machine.

## Requirements

- Vagrant 1.7 or newer
- Ansible 2.0 or newer

## How to use

1. Download the Ansible roles:
  ```
  $ ansible-galaxy install -f -p roles/ -r requirements.yml
  ```

2. Create the virtual machine and provision it:
  ```
  $ vagrant up
  ```

3. To ssh to the VM, run:
  ```
  $ vagrant ssh
  ```

4. To (re-)provision the VM, run:
   ```
   $ vagrant provision
   ```
