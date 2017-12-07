server '13.112.134.244', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/ubuntu/.ssh/id_rsa'
