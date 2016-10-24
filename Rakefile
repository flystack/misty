require 'rake/testtask'

task :default => [:test]

desc "Run all tests"
task :test => [:unit, :integration]

desc "Run unit tests"
task :unit do
  Rake::TestTask.new do |t|
    t.name = 'unit'
    t.libs << "test/unit"
    t.test_files = FileList['test/unit/**/*_test.rb']
    t.verbose = true
  end
end

desc "Run integration tests"
task :integration do
  Rake::TestTask.new do |t|
    t.name = 'integration'
    t.libs << "test/integration"
    t.test_files = FileList['test/integration/**/*_test.rb']
    t.verbose = true
  end
end
