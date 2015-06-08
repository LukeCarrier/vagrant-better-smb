# Better SMB support for Vagrant

Vagrant's core SMB synced folder implementation doesn't use guest and host
capabilities and doesn't provide developers with an easy means of extending
support to non-Windows platforms. This plugin aims to fix this problem by
providing an alternative synced folder implementation.

* * *

## Work in progress

Don't use me for anything important just yet -- I'm still undergoing heavy
development. I'll be on RubyGems soon.

## Using

To install the plugin:

    $ vagrant plugin install vagrant-better-smb

Then, in your ```Vagrantfile```:

    config.vm.network :private_network, ip: "10.10.10.10"

    config.vm.synced_folder "my/src", "T:", type: "better_smb",
                            better_smb_machine_ip: "10.10.10.10",
                            better_smb_share_name: "src",
                            better_smb_host_ip: "your host IP",
                            better_smb_share_user: "your username",
                            better_smb_share_password: "your password"

## Debugging

1. Have you added your user account as an SMB user with
   ```sudo smbpasswd -a <your username>```?
2. Is your password up to date? Update it with ```smbpasswd```.
3. Can you see your share in ```smbclient -L 127.0.0.1 -U <your username>```?
4. Have you configured SELinux correctly? Allow Samba to access home directories
   with ```setsebool -P samba_enable_home_dirs 1```

## Hacking

1. Install Ruby and Bundler.
2. If you need any local dependencies (i.e. ```json```), pop them into a new
   file called ```Gemfile.local```. We'll source it for you -- there's no need
   to alter the top level ```Gemfile```.
3. Install the bundle with ```bundle install```.
4. Use Vagrant as normal -- just run it with ```bundle exec vagrant```.

### Building

It's easy:

    $ gem build vagrant-better-smb.gemspec

### To do

* Enable multiple clients to connect to the same SMB share
* Sanity check and cleanse the values we're placing in samba.conf
* Implement support for Windows hosts
* Implement support for Linux guests
* Clean up existing shares
* Ensure Linux server implementation works outside of Fedora
