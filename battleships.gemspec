Gem::Specification.new do |s|
  s.name              =	'battleships'
  s.version           =	'1.0.0'
  s.summary           =	"The game of battleships"
  s.description       =	"The game of battleships created as an exercise in TDD."
  s.author            =	"Joe Haig"
  s.email             =	"josephhaig@gmail.com"
  s.homepage          =	"https://github.com/jrmhaig/battleships"
  s.files             =	Dir["lib/*rb"]
  s.extra_rdoc_files  =	Dir['*.md']
  s.executables << 'battleships'
  s.license           = "MIT"
 
  s.add_runtime_dependency 'colorize', '~> 0.8'
  s.add_development_dependency 'rspec', '~> 3.7'
  s.add_development_dependency 'rubocop', '~> 0.52'
  s.add_development_dependency 'simplecov', '~> 0.15'
end
