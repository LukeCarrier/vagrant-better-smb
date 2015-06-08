#
# Better SMB for Vagrant
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

$:.unshift File.expand_path("../lib", __FILE__)
require "vagrant-better-smb/version"

Gem::Specification.new do |s|
  s.name     = "vagrant-better-smb"
  s.version  = VagrantPlugins::BetterSmb::VERSION
  s.license  = "GPL v3"
  s.authors  = "Luke Carrier"
  s.email    = "luke@carrier.im"
  s.homepage = "https://github.com/LukeCarrier/vagrant-better-smb"

  s.summary     = "Better SMB support for Vagrant"
  s.description = s.summary

  s.files        = Dir["lib/**/*.rb"] + Dir["*.md"] + Dir["templates/**/*"]
  s.require_path = "lib"
end
