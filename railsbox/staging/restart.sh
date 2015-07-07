#!/bin/bash

ansible-playbook $@ -i inventory ../ansible/restart.yml
