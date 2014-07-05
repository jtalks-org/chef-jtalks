Chef JTalks Cookbook
----

Contains recipes to prepare environment for JTalks components deployment - should install required dependencies, MySQL,
configure firewalls, etc. Go through [Tests Kichen](http://kitchen.ci/) guides in order to get a notion on how the
development is going on.

## Installation

The process is described on [Test Kitchen site](http://kitchen.ci/docs/getting-started/installing) itself. Summary:
- Install Ruby. On *nix you'd probably want to use [rbenv](https://github.com/sstephenson/rbenv) utility for this purpose.
 All the installation scripts and most of utilities are written in Ruby.
- Install [Vagrant](http://www.vagrantup.com/) & [VirtualBox](https://www.virtualbox.org/wiki/Downloads) for running
 virtual machines.
- `gem install test-kitchen` - this installs a utility to easy startup an env with the cookbook and run tests if needed.
 If this fails, you probably didn't install Ruby correctly. Run `kitchen version` to check the gem was installed.
- Run `kitchen converge` to startup a VM with the cookbooks and `kitchen verify` to run the integration tests.
