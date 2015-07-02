#!/bin/bash

ansible-playbook $@ -s -u vagrant -i inventory ../ansible/deploy.yml
