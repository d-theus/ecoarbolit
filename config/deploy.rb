# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'ecoarbolit'
set :repo_url, 'https://github.com/d-theus/ecoarbolit.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

set :pty, true

# Docker specific
namespace :docker do
  set :user, 'dtheus'
  set :proxy, 'nginx'
  set :backend, 'thin'
  set :public, 'public'
  set :rails, 'rails'
  set :db, 'postgres'
  set :smtp, 'postfix'
  set :proxy_links, -> { (fetch(:http_backends) + fetch(:https_backends)).reduce('') { |acc,i| acc += " --link #{fetch :rails}#{i}"; acc } }
  set :volumes, "--volumes-from #{fetch :public}"
  set :http_backends, [1,2]
  set :https_backends, []
  set :backends_count, ->{ fetch(:http_backends).count + fetch(:https_backends).count }
end


namespace :deploy do
  after :published, :upload_secrets do
    on roles :app do
      upload! '.rbenv-vars', current_path
    end
  end

  after :published, 'docker:setup'
  after :published, 'docker:start'
end