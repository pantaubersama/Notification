append :linked_files, ".ruby-version", ".env.staging"

set :rvm_type, :auto
set :rvm_ruby_version, 'ruby-2.5.3'

set :deploy_to, '/home/ubuntu/notification_service_staging'

set :branch, 'staging'
set :rails_env, 'staging'
set :unicorn_roles, :web
set :whenever_roles, :app

set :sidekiq_env, "staging"
set :sidekiq_roles, :app
set :sidekiq_monit_use_sudo, true
set :sidekiq_monit_conf_file, "sidekiq_notif__#{fetch(:sidekiq_env)}.conf"
set :sidekiq_service_name, "sidekiq_notif_#{fetch(:application)}_#{fetch(:sidekiq_env)}"

# set :sneakers_default_hooks, true
# set :sneakers_pid, File.join(shared_path, 'tmp', 'pids', 'sneakers.pid')
# set :sneakers_env, fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
# set :sneakers_log, File.join(shared_path, 'log', 'sneakers.log')
# set :sneakers_roles, :app
# set :sneakers_processes, 1
# set :sneakers_run_config, -> { true }
# set :sneakers_workers, ["Your::Subscriber::Class"]

server "52.77.101.168", user: "ubuntu", roles: %w{web db}
server "13.228.240.205", user: "ubuntu", roles: %w{app}

set :ssh_options, {
  forward_agent: false,
  auth_methods: %w(publickey)
 }

 set :keep_releases, 5

 after 'deploy:publishing', 'deploy:restart'
 namespace :deploy do

  task :restart do
    invoke 'unicorn:restart'
  end

end

# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
