Chef JTalks Cookbook
----

**CHEF PROVED TO BE AN UNRELYABLE TOOL AND WE'RE MOVING TO DOCKER, SEE OUR FIRST STEPS [HERE] (https://github.com/jtalks-org/jtalks-cicd).**

Contains recipes to prepare environment for JTalks components deployment - should install required dependencies, MySQL,
configure firewalls, etc. Go through [Tests Kichen](http://kitchen.ci/) guides in order to get a notion on how the
development is going on.

## Installation

The process is described on [Test Kitchen site](http://kitchen.ci/docs/getting-started/installing) itself. Summary:
- You have to install [Chef Development Kit](https://downloads.getchef.com/chef-dk/) which includes all necessary tools for installing environment (Note please that there shouldn't be some specific symbols in installation path - cyrillic, accented etc.)
 All the installation scripts and most of utilities are written in Ruby.
- Install [Vagrant](http://www.vagrantup.com/) & [VirtualBox](https://www.virtualbox.org/wiki/Downloads) for running
 virtual machines.
- `gem install test-kitchen` - this installs a utility to easy startup an env with the cookbook and run tests if needed.
 If this fails, you probably didn't install Ruby correctly. Run `kitchen version` to check the gem was installed.
- Run `kitchen converge` to startup a VM with the cookbooks and `kitchen verify` to run the integration tests.
If you want to install VM only use `kitchen converge system`.
All those commands should be launched when VirtualBox is run.

## Misc

In order to speed up working with Test Kitchen, you can follow [this advise](https://gist.github.com/fnichol/7551540) to
configure an HTTP proxy.
