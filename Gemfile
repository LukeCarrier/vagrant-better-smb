#
# Better SMB for Vagrant
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

source "https://rubygems.org"

gemspec

group :development do
  gem "vagrant", git: "https://github.com/mitchellh/vagrant.git"
end

group :plugins do
  gem "vagrant-better-smb", path: "."
end

local_gemfile = File.expand_path("../Gemfile.local", __FILE__)
if File.file? local_gemfile
  self.instance_eval Bundler.read_file(local_gemfile)
end
