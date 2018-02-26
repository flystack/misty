require 'rake/testtask'
require 'rdoc/task'

task :default => [:test]

desc 'Run all tests'
task :test => [:unit, :integration]

desc 'Run unit tests'
task :unit do
  Rake::TestTask.new do |t|
    t.name = 'unit'
    t.libs << 'test/unit'
    t.test_files = FileList['test/unit/**/*_test.rb']
    t.verbose = true
  end
end

desc 'Run integration tests'
task :integration do
  Rake::TestTask.new do |t|
    t.name = 'integration'
    t.libs << "test/integration"
     t.test_files = FileList['test/integration/**/*_test.rb']
    t.verbose = true
  end
end

desc 'Build RDoc'
RDoc::Task.new do |rdoc|
  rdoc.main = "index.html"
  rdoc.rdoc_files.include("lib")
  rdoc.rdoc_dir = 'docs'
end

desc 'Build APIs'
task :build => 'build:all'

namespace :build do
  task :all => [:setup, :run]

  desc 'Clean Build'
  task :clean do
    require 'fileutils'
    FileUtils.rm_r('build') if Dir.exist?('build')
  end

  desc 'Prepare Build APIs'
  task :setup do
    Dir.mkdir('build') unless Dir.exist?('build')
    Dir.mkdir('build/APIs') unless Dir.exist?('build/APIs')
    unless Dir.exist?('./build/openstack-APIs')
    `git clone https://github.com/flystack/openstack-APIs build/openstack-APIs`
    end
  end

  desc 'Process APIs'
  task :run do
    require 'pp'
    require 'yaml'

    Dir.glob("build/openstack-APIs/APIs/*/*.yaml") do |entry|
      ext = ''
      path = entry.gsub('.yaml', '').split('/')
      name = path[-2]
      version = path[-1].gsub(/\./, '_')
      ext << '_ext' if version =~ /_ext/
      payload = YAML.load_file(entry)

      Dir.mkdir("build/APIs/#{name}") unless Dir.exist?("build/APIs/#{name}")
      puts "Generating build/APIs/#{name}/#{name}_#{version}.rb"
      File.open("build/APIs/#{name}/#{name}_#{version}.rb", 'w') do |f|
        f << "module Misty::Openstack::#{name.capitalize}#{version.capitalize}\n"

        f << "  def tag\n"
        f << "    '#{payload[:tag]}'\n"
        f << "  end\n\n"

        f << "  def api#{ext}\n"
        PP.pp(payload[:api], f)
        f << "  end\n"
        f << "end\n"
      end
    end
  end

  desc 'Compare APIs'
  task :diff do
    Dir.glob("build/APIs/*/*.rb") do |entry|
      path = entry.split('/')
      name = path[-2]
      file = path[-1]
     `diff lib/misty/openstack/#{name}/#{file} build/APIs/#{name}/#{file}`
     puts "Not the same: #{name}/#{file}" unless $? == 0
    end
  end
end
