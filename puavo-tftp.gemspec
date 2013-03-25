Gem::Specification.new { |s|
	s.name         = 'puavo-tftp'
	s.version      = '0.5.7.pre'
	s.summary      = "Read-only TFTP server with hooks."
	s.description  = "puavo-tftp is a dynamic read-only TFTP server. It's dynamic in the sense that it can be configured to execute script hooks for a set of matched files on read requests (RRQ) instead of reading files from the file system. The standard output of the script will be used as the file content for those read requests."
	s.authors      = [
		"Opinsys",
	]
	s.email        = [ 'root@localhost' ]
	s.homepage     = 'https://github.com/philipp-kempgen/puavo-tftp'
	files          = Dir[ 'puavo-tftp/**/*.rb' ]
	files         += Dir[ 'test/**/*' ]
	files         += [
		'puavo-tftpd',
		'puavo-tftp.yml',
	]
	s.files        = files
#	s.test_files   = Dir[ 'test/**/*' ]
	s.extra_rdoc_files = [
		'README.md',
		'COPYING',
	]
	s.require_path = '.'
	s.bindir       = '.'
	s.executables  = [
		'puavo-tftpd',
	]
	s.required_ruby_version = '>= 1.9.2'
	s.add_runtime_dependency "eventmachine", "~> 1.0"
}


# Local Variables:
# mode: ruby
# End:

