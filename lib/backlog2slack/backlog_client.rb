require 'net/http'
require 'uri'
require 'json'
require 'slack-notify'

module Backlog2Slack
  class BacklogClient

    def initialize(config)
      @config = config
    end

    def notify_issue
      projects do |project|
        issues(project.id) do |issue|
          send_slack(project, issue)
        end
      end
    end

    def send_slack(project, issue)
      return unless notify_target?(issue)

      client = SlackNotify::Client.new(@config.slack.team, @config.slack.token, {
        channel: "##{@config.slack.channel}",
        username: @config.slack.username,
        icon_url: @config.slack.icon_url,
        icon_emoji: @config.slack.icon_emoji
      })
      client.notify(slack_message(project, issue))
    end

    def notify_target?(issue)
      issue.updated >= @config.target_time
    end

    def issue_created?(issue)
      issue.created >= (issue.updated - @config.interval)
    end

    def slack_message(project, issue)
      user = ''
      if issue.assign_id
        slack_user = @config.user[issue.assign_id]
        if slack_user
          user = "assign: <https://#{@config.slack.team}.slack.com/team/#{slack_user}|@#{slack_user}>"
        end
      end

      issue_link = "<https://#{@config.backlog.space}.backlog.jp/view/#{issue.issueKey}|#{project.name} - #{issue.summary}>"

      if issue_created?(issue)
        "Created issue #{issue_link} #{user}"
      else
        "Updated issue #{issue_link} #{user}"
      end
    end

    def projects
      projects = request(api_url('projects'))
      projects.each do |project|
        yield Backlog::Project.new(project)
      end
    end

    def issues(project_id)
      api_url = "#{api_url('issues')}&sort=updated&projectId[]=#{project_id}&updatedSince=#{@config.target_time.strftime('%Y-%m-%d')}"
      issues = request(api_url)
      issues.each do |issue|
        yield Backlog::Issue.new(issue)
      end
    end

    def show_member
      users = request(api_url('users'))
      users.each do |user|
        puts Backlog::User.new(user)
      end
    end

    def api_url(api)
      "https://#{@config.backlog.space}.backlog.jp/api/v2/#{api}?apiKey=#{@config.backlog.api_key}"
    end

    def request(api)
      json = Net::HTTP.get(URI.parse(api))
      JSON.parse(json)
    end
  end
end


