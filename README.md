Celery Cookbook
===============

This cookbook installs and configures [celery](http://www.celeryproject.org/), and runs it through
[supervisor](http://supervisord.org/).

Requirements
------------

### Platforms

The following platforms have integration tests written for them. Other platforms may work, depending
on which platforms are supported by the [python](https://github.com/poise/python) and
[supervisor](https://github.com/poise/supervisor) cookbooks.

* Ubuntu 14.04, 12.04
* CentOS 6.5, 5.10

### Cookbooks

* [python](https://github.com/poise/python)
* [supervisor](https://github.com/poise/supervisor)

Attributes
----------

See `attributes/default.rb` for all default values.

* `node['celery']['autostart']` - Whether to start celery as running or not
* `node['celery']['user']` - The user to run celery as, defaults as root
* `node['celery']['group']` - The group to run celery as, defaults as root
* `node['celery']['workdir']` - The directory to change celery to run in
* `node['celery']['app']` - Application instance name
* `node['celery']['include']` - Modules to import for the worker on start
* `node['celery']['config']` - Attributes that will be written out as a JSON file for consumption
by the task
* `node['celery']['taskfile']` - If specified, attempts a `remote_file` download. Expects a URI to
get a task file. If none is specified, uses the default one in this cookbook.

Recipes
-------

### celery::default

The default recipe that will install celery through pip, write out configuration
files and run it using supervisord.

It will also create the working directory, create a JSON file if provided it through attributes,
and sync the task file provided to the system.

You must write or include your own task file to get much use out of this cookbook. An example
[task](/files/default/tasks.py) can be found in this cookbook that has one method to add two
numbers together. If you override the `node['celery']['taskfile']` attribute, the cookbook
will attempt to download the task and place it in the working directory.

Usage
-----

If including this recipe in another recipe you're writing, simply add:

```ruby
include_recipe 'celery'
```

If you're running this through Chef, you can add it to your run list with:

```ruby
chef.add_recipe 'celery'
```

For a full example on using this cookbook, take a look at the
[RabbitMQ Cluster](https://github.com/turbine-web/rabbitmq-cluster), which has a Celery task example.

Testing
-------

[![Build Status](https://travis-ci.org/turbine-web/celery-cookbook.png?branch=master)](https://travis-ci.org/turbine-web/celery-cookbook)

The cookbook provides the following Rake tasks for testing:

    rake test         # Runs all lint and integration tests
    rake lint         # Runs RuboCop and Foodcritic
    rake integration  # Runs lint and RSpec
    rake kitchen      # Runs all kitchen tests
    rake spec         # Runs RSpec
    rake foodcritic   # Runs Foodcritic
    rake rubocop      # Runs RuboCop

License
-------

Copyright:: 2014, Warner Bros. Entertainment Inc. Developed by Turbine, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
