append :linked_files, ".ruby-version", ".env.staging"

set :rvm_type, :auto
set :rvm_ruby_version, 'ruby-2.5.3'

set :deploy_to, '/home/ubuntu/notification_service_staging'

set :branch, 'staging'
set :rails_env, 'staging'
set :unicorn_roles, :web

set :whenever_roles, :app

set :sneakers_roles, :app
set :sneakers_processes, 1
set :sneakers_run_config, -> { true }
set :sneakers_workers, ["Subscribers::JanjiPolitik", "Subscribers::Pilpres", "Subscribers::Profile", "Subscribers::Question", "Subscribers::Quiz", "Subscribers::Badge", "Subscribers::WsWordService"]

server "52.77.101.168", user: "ubuntu", roles: %w{web db}
server "13.228.240.205", user: "ubuntu", roles: %w{app}

set :ssh_options, {
  forward_agent: false,
  auth_methods:  %w(publickey)
}

set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do

  task :restart do
    invoke 'unicorn:restart'
  end
end
