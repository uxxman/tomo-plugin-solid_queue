# tomo-plugin-solid_queue

[![Gem Version](https://img.shields.io/gem/v/tomo-plugin-solid_queue)](https://rubygems.org/gems/tomo-plugin-solid_queue)
[![Gem Downloads](https://img.shields.io/gem/dt/tomo-plugin-solid_queue)](https://www.ruby-toolbox.com/projects/tomo-plugin-solid_queue)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/uxxman/tomo-plugin-solid_queue/ci.yml)](https://github.com/uxxman/tomo-plugin-solid_queue/actions/workflows/ci.yml)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/uxxman/tomo-plugin-solid_queue)](https://codeclimate.com/github/uxxman/tomo-plugin-solid_queue)

This is a [tomo](https://github.com/mattbrictson/tomo) plugin that provides tasks for managing [solid_queue](https://github.com/rails/solid_queue) via [systemd](https://en.wikipedia.org/wiki/Systemd), based on the recommendations in the solid_queue documentation. This plugin assumes that you are also using the tomo `rbenv` and `env` plugins, and that you are using a systemd-based Linux distribution like Ubuntu 18 LTS.

**This plugin requires solid_queue 0.6.0 or newer.**

---

- [Installation](#installation)
- [Settings](#settings)
- [Tasks](#tasks)
- [Recommendations](#recommendations)
- [Support](#support)
- [License](#license)
- [Code of conduct](#code-of-conduct)
- [Contribution guide](#contribution-guide)

## Installation

Run:

```
$ gem install tomo-plugin-solid_queue
```

Or add it to your Gemfile:

```ruby
gem "tomo-plugin-solid_queue"
```

Then add the following to `.tomo/config.rb`:

```ruby
plugin "solid_queue"

setup do
  # ...
  run "solid_queue:setup_systemd"
end

deploy do
  # ...
  # Place this task at *after* core:symlink_current
  run "solid_queue:restart"
end
```

### enable-linger

This plugin installs solid_queue as a user-level service using `systemctl --user`. This allows solid_queue to be installed, started, stopped, and restarted without a root user or sudo. However, when provisioning the host you must make sure to run the following command as root to allow the solid_queue process to continue running even after the tomo deploy user disconnects:

```
# run as root
$ loginctl enable-linger <DEPLOY_USER>
```

## Settings

| Name                  | Purpose |
| --------------------- | ------- |
| `solid_queue_systemd_service` | Name of the systemd unit that will be used to manage solid_queue <br>**Default:** `"solid_queue_%{application}.service"`   |
| `solid_queue_systemd_service_path` | Location where the systemd unit will be installed <br>**Default:** `".config/systemd/user/%{solid_queue_systemd_service}"`   |
| `solid_queue_systemd_service_template_path` | Local path to the ERB template that will be used to create the systemd unit <br>**Default:** [service.erb](https://github.com/uxxman/tomo-plugin-solid_queue/blob/main/lib/tomo/plugin/solid_queue/service.erb)   |

## Tasks

### solid_queue:setup_systemd

Configures systemd to manage solid_queue. This means that solid_queue will automatically be restarted if it crashes, or if the host is rebooted. This task essentially does two things:

1. Installs a `solid_queue.service` systemd unit
1. Enables it using `systemctl --user enable`

Note that these units will be installed and run for the deploy user. You can use `:solid_queue_systemd_service_template_path` to provide your own template and customize how solid_queue and systemd are configured.

`solid_queue:setup_systemd` is intended for use as a [setup](https://tomo.mattbrictson.com/commands/setup/) task. It must be run before solid_queue can be started during a deploy.

### solid_queue:restart

Gracefully restarts the solid_queue service via systemd, or starts it if it isn't running already. Equivalent to:

```
systemctl --user restart solid_queue.service
```

### solid_queue:start

Starts the solid_queue service via systemd, if it isn't running already. Equivalent to:

```
systemctl --user start solid_queue.service
```

### solid_queue:stop

Stops the solid_queue service via systemd. Equivalent to:

```
systemctl --user stop solid_queue.service
```

### solid_queue:status

Prints the status of the solid_queue systemd service. Equivalent to:

```
systemctl --user status solid_queue.service
```

### solid_queue:log

Uses `journalctl` (part of systemd) to view the log output of the solid_queue service. This task is intended for use as a [run](https://tomo.mattbrictson.com/commands/run/) task and accepts command-line arguments. The arguments are passed through to the `journalctl` command. For example:

```
$ tomo run -- solid_queue:log -f
```

Will run this remote script:

```
journalctl -q --user-unit=solid_queue.service -f
```

## Recommendations

### solid_queue configuration

Add a `config/solid_queue.yml` file to your application (i.e. checked into git) and use that to configure solid_queue, using environment variables as necessary. For examples see https://github.com/rails/solid_queue?tab=readme-ov-file#configuration.

## Support

If you want to report a bug, or have ideas, feedback or questions about the gem, [let me know via GitHub issues](https://github.com/uxxman/tomo-plugin-solid_queue/issues/new) and I will do my best to provide a helpful answer. Happy hacking!

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Code of conduct

Everyone interacting in this project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Contribution guide

Pull requests are welcome!
