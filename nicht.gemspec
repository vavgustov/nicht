lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nicht/version"

Gem::Specification.new do |spec|
  spec.name          = "nicht"
  spec.version       = Nicht::VERSION
  spec.authors       = ["Vladimir Avgustov"]
  spec.email         = ["vavgustov@gmail.com"]

  spec.summary       = %q{This library allow you to see gems usage per your projects.}
  spec.description   = %q{This library allow you to see gems usage per your projects.}
  spec.homepage      = "https://github.com/vavgustov/nicht"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.1.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "awesome_print", ">= 1.6", "< 1.9"
end
