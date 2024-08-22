require "tomo"
require_relative "solid_queue/tasks"
require_relative "solid_queue/version"

module Tomo::Plugin::SolidQueue
  extend Tomo::PluginDSL

  tasks Tomo::Plugin::SolidQueue::Tasks
  defaults solid_queue_systemd_service: "solid_queue_%{application}.service",
           solid_queue_systemd_service_path: ".config/systemd/user/%{solid_queue_systemd_service}",
           solid_queue_systemd_service_template_path: File.expand_path("solid_queue/service.erb", __dir__)
end
