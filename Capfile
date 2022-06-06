# frozen_string_literal: true

# Load DSL and set up stages
require 'capistrano/setup'
require 'capistrano/sitemap_generator'
# Include default deployment tasks
require 'capistrano/deploy'
require 'whenever/capistrano'
# require 'capistrano/sidekiq'
# install_plugin Capistrano::Sidekiq
# install_plugin Capistrano::Sidekiq::Systemd
# install_plugin Capistrano::Sidekiq::Monit
# set :sidekiq_monit_use_sudo, false

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
require 'capistrano/rvm'
require 'capistrano/rails'
require 'capistrano/passenger'
# require "capistrano/rbenv"
# require "capistrano/chruby"
require 'capistrano/bundler'
# require "capistrano/rails/assets"
# require "capistrano/rails/migrations"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

set :rvm_type, :user # Defaults to: :auto
set :rvm_ruby_version, '2.7.2' # Defaults to: 'default'

set :sidekiq_roles, -> { :app }
set :sidekiq_systemd_unit_name, 'sidekiq'

namespace :sidekiq do
  desc 'Quiet sidekiq (stop fetching new tasks from Redis)'
  task :quiet do
    on roles fetch(:sidekiq_roles) do
      # See: https://github.com/mperham/sidekiq/wiki/Signals#tstp
      execute :systemctl,  'kill', '-s', 'SIGTSTP', fetch(:sidekiq_systemd_unit_name), raise_on_non_zero_exit: false
    end
  end

  desc 'Stop sidekiq (graceful shutdown within timeout, put unfinished tasks back to Redis)'
  task :stop do
    on roles fetch(:sidekiq_roles) do
      # See: https://github.com/mperham/sidekiq/wiki/Signals#tstp
      execute :systemctl,  'kill', '-s', 'SIGTERM', fetch(:sidekiq_systemd_unit_name), raise_on_non_zero_exit: false
    end
  end

  desc 'Start sidekiq'
  task :start do
    on roles fetch(:sidekiq_roles) do
      execute :systemctl,  'start', fetch(:sidekiq_systemd_unit_name)
    end
  end

  desc 'Restart sidekiq'
  task :restart do
    on roles fetch(:sidekiq_roles) do
      execute :systemctl, 'restart', fetch(:sidekiq_systemd_unit_name)
    end
  end
end

after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:updated', 'sidekiq:stop'
after 'deploy:published', 'sidekiq:start'
after 'deploy:failed', 'sidekiq:restart'
