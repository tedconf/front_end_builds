begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'FrontEndBuilds'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
rescue LoadError
  # no rspec available
end

namespace :admin do
  task :build do
    Dir.chdir('admin') do
      sh 'ember build production'
    end

    # Copy the dist to public
    FileUtils.rm_r 'public/front_end_builds'
    FileUtils.mv 'admin/dist', 'public/front_end_builds'

    # Move the index out of public
    FileUtils.mv 'public/front_end_builds/index.html', 'app/views/front_end_builds/admin/index.html.erb'
  end
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'


Bundler::GemHelper.install_tasks
