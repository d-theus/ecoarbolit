# config valid only for current version of Capistrano
lock '3.6.0'

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

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


set :chef_dir, File.expand_path('chef', File.dirname(__FILE__))

set :pty, true

set :keep_releases, 5

namespace :docker do
  namespace :compose do
    task :up do
      on roles :app do
        within current_path do
          execute 'docker-compose', 'up', '-d'
        end
      end
    end

    task :down do
      on roles :app do
        if test("[ -d #{current_path} ]") and capture('docker ps -q').lines.any?
          within current_path do
            execute 'docker-compose', 'down'
          end
        end
      end
    end

    task :onboot do
      on roles :app do
        execute "echo '@reboot cd #{current_path} && while [[ -z  $(#{capture 'which pgrep'} docker) ]]; do sleep 2; done && #{capture 'which docker-compose'} up -d' | crontab -"
      end
    end
  end

  task :persistence do
    config = YAML.load(File.read File.expand_path('docker-compose.yml'))
    on roles :app do
      config['volumes'].each do |_, val|
        name = val['external']['name']
        execute "docker volume ls | grep #{name} &>/dev/null; if [ $? -ne 0 ]; then docker volume create --name #{name}; fi"
      end
    end
  end
end

namespace :chef do
  task :cook do
    Dir.chdir(fetch :chef_dir) do
      nodes = JSON.parse(`knife search -z node "role:app" -a ipaddress -a name -F json 2>/dev/null`)["rows"]
      nodes.each do |node|
        puts "Another node: #{node.inspect}"
        node.keys.each do |k|
          attrs = node[k]
          system "knife solo cook admin@#{attrs['ipaddress']} -N #{attrs['name']}"
        end
      end
    end
  end
end

namespace :deploy do
  task :upload_secret do
    on roles :app do
      upload! '.rbenv-vars', current_path
    end
  end

  after :updated,   'docker:compose:down'
  after :published, :upload_secret
  after :published, 'docker:persistence'
  after :published, 'docker:compose:up'
end
