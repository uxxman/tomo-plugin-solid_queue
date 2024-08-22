require_relative "lib/tomo/plugin/solid_queue/version"

Gem::Specification.new do |spec|
  spec.name = "tomo-plugin-solid_queue"
  spec.version = Tomo::Plugin::SolidQueue::VERSION
  spec.authors = ["Muhammad Usman"]
  spec.email = ["uxman.sherwani@gmail.com"]

  spec.summary = "Solid Queue deployment tasks for tomo"
  spec.homepage = "https://github.com/uxxman/tomo-plugin-solid_queue"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/uxxman/tomo-plugin-solid_queue/issues",
    "changelog_uri" => "https://github.com/uxxman/tomo-plugin-solid_queue/releases",
    "source_code_uri" => "https://github.com/uxxman/tomo-plugin-solid_queue",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "tomo", "~> 1.0"
end
