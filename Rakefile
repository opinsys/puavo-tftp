#!/usr/bin/env rake

require 'rake'

desc "Default: \"rake help\""
task :default => :help

desc "Display the help screen."
task( :help ) {
	sh "rake -T"
}

desc "Run the tests."
task( :test ) {
	sh "ruby 'test/run.rb'"
}

desc "Build gem package."
task( :gem ) {
	sh "gem build 'puavo-tftp.gemspec'"
}


# Local Variables:
# mode: ruby
# indent-tabs-mode: t
# End:

