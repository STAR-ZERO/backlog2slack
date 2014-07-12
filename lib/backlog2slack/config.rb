require 'yaml'
require 'time'

module Backlog2Slack
  class Config
    attr_reader :interval, :target_time, :backlog, :slack, :user

    def initialize
      yaml = load_yaml
      @backlog = Backlog.new(yaml)
      @slack = Slack.new(yaml)
      @user = User.new(yaml)
      @interval = yaml['interval'].to_i * 60
      @target_time = Time.now - @interval
    end

    class Backlog
      attr_reader :space, :api_key
      def initialize(yaml)
        @space = yaml['backlog']['space']
        @api_key = yaml['backlog']['api_key']
      end
    end

    class Slack
      attr_reader :team, :token, :channel, :username, :icon_url, :icon_emoji
      def initialize(yaml)
        @team = yaml['slack']['team']
        @token = yaml['slack']['token']
        @channel = yaml['slack']['channel']
        @username = yaml['slack']['username']
        @icon_url = yaml['slack']['icon_url']
        @icon_emoji = yaml['slack']['icon_emoji']
      end
    end

    class User
      def initialize(yaml)
        @user = yaml['user']
      end

      def [](backlog_id)
        @user[backlog_id.to_i]
      end
    end

    private
      def load_yaml
        path = File.expand_path('../../config/config.yaml', File.dirname(__FILE__))
        YAML.load_file(path)
      end
  end
end
