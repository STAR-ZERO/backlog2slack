require 'clockwork'
require './backlog2slack'

module Clockwork
  handler do |job|
    Backlog2Slack::BacklogClient.new(Backlog2Slack::Config.new).notify_issue
  end

  every(Backlog2Slack::Config.new.interval.seconds, 'notify_issue')
end
