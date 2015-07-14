# Ansible managed: /Users/vasvitali/projects/brug/railsbox/ansible/roles/unicorn/templates/unicorn.rb.j2 modified on 2015-06-12 11:59:54 by vasvitali on 192.168.1.35

working_directory '/brug'

pid '/brug/tmp/unicorn.development.pid'

stderr_path '/brug/log/unicorn.err.log'
stdout_path '/brug/log/unicorn.log'

listen '/tmp/unicorn.development.sock'

worker_processes 2

timeout 30
