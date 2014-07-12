module Backlog2Slack

  require 'thor'

  class CLI < Thor

    def initialize(*args)
      super
      @backlog_client = BacklogClient.new(Config.new)
    end

    desc 'execute', 'Execute Backlog2Slack'
    def execute
      @backlog_client.notify_issue
    end

    desc 'member', 'Show Backlog member'
    def member
      @backlog_client.show_member
    end

    default_task :execute
  end
end
