#! /usr/bin/env bash
# This should run the OLD Pyramid tests (functional/unit) on the vagrant guest
# from the vagrant host
vagrant ssh -c "mysql -u root -pY0xbH450qZ4NuyPl -e 'DROP DATABASE IF EXISTS oldtests;'"
vagrant ssh -c "mysql -u root -pY0xbH450qZ4NuyPl -e 'CREATE DATABASE oldtests DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;'"
vagrant ssh -c "mysql -u root -pY0xbH450qZ4NuyPl -e \"GRANT ALL PRIVILEGES ON oldtests.* TO 'old'@'localhost' IDENTIFIED BY 'demo';\""
vagrant ssh -c 'cd /vagrant/src/old; /usr/share/python/old/bin/pytest old/tests/ -v --junitxml=junitxml.xml'
