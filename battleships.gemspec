Gem::Specification.new do |s|
  s.name = 'battleships'
  s.version = '1.0.0'
  s.date = '2014-12-22'
  s.summary = "Battleships"
  s.description = "battleships in Ruby"
  s.author = "Joe Haig"
  s.email = "josephhaig@gmail.com"
  s.homepage = "https://github.com/jrmhaig/battleships"
  s.files = Dir["{bin,lib}/**/*"] + %w(LICENSE README.md)
  s.executables = ['battleships']
  s.add_runtime_dependency 'colorize'
end
