# -*- encoding: utf-8 -*-
# stub: sassc-embedded 1.80.4 ruby lib vendor/github.com/sass/sassc-ruby/lib

Gem::Specification.new do |s|
  s.name = "sassc-embedded".freeze
  s.version = "1.80.4".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/sass-contrib/sassc-embedded-shim-ruby/issues", "documentation_uri" => "https://rubydoc.info/gems/sassc", "funding_uri" => "https://github.com/sponsors/ntkme", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/sass-contrib/sassc-embedded-shim-ruby/tree/v1.80.4" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze, "vendor/github.com/sass/sassc-ruby/lib".freeze]
  s.authors = ["\u306A\u3064\u304D".freeze]
  s.date = "2025-02-21"
  s.description = "An embedded sass shim for SassC.".freeze
  s.email = ["i@ntk.me".freeze]
  s.homepage = "https://github.com/sass-contrib/sassc-embedded-shim-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.1".freeze)
  s.rubygems_version = "3.6.5".freeze
  s.summary = "Use dart-sass with SassC!".freeze

  s.installed_by_version = "3.6.7".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<sass-embedded>.freeze, ["~> 1.80".freeze])
end
