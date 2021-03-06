Gem::Specification.new do |s|
	s.name = 'valid_array'
	s.version = File.read('VERSION').chomp
	s.specification_version = 1
	s.date = '2013-10-18'
	
	s.homepage = 'http://github.com/kevincox/valid_array'
	s.authors = ['Kevin Cox', 'Ryan Biesemeyer']
	s.email = 'kevincox@kevincox.ca'
	s.summary = 'Provides methods for controlling the elements added to an array.'
	s.description = <<-'EOS'
The valid_array gem provides to create an Array that enforces certian
properties.  Each element added to the array is passed to a validator function
written by you.  This function can raise errors, drop items or change them.

vaild_array also provides compatibility with the typed-array gem.  There is both
'valid_array/typed_array' which imports to `ValidArray::TypedArray` and a fully
compatible 'valid-array' which passes 'valid-array's own test suite.
	EOS
	s.licenses = ['MIT']
	
	s.files = Dir['lib/**/*.rb', 'spec/**/*.rb']
	s.extra_rdoc_files = [
		'LICENSE',
		'README.rdoc'
	]
	s.require_paths = ['lib']
	
	s.add_development_dependency 'rake'
	s.add_development_dependency 'rdoc', ['~> 4.0']
	s.add_development_dependency 'rspec', ['~> 2.0']
	
	s.rubygems_version = '2.0.3'
end

