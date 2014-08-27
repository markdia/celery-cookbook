require 'rspec/expectations' # shouldn't be necessary...
require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |c|
  c.platform  = 'ubuntu'
  c.version   = '12.04'
  c.log_level = :warn
  c.color     = true
  c.formatter = :documentation
end

# Required for Growl notifications to work properly
def gem_available?(name)
  Gem::Specification.find_by_name(name)
rescue Gem::LoadError
  false
rescue
  Gem.available?(name)
end

if gem_available?('safe_yaml')
  SafeYAML::OPTIONS[:deserialize_symbols] = true
  SafeYAML::OPTIONS[:default_mode] = 'unsafe'
end
