require 'time'

module Backlog2Slack
  module Backlog
    class Issue
      attr_reader :id, :issueKey, :summary, :status, :assign_id, :created, :updated

      def initialize(json)
        @id = json['id']
        @issueKey = json['issueKey']
        @summary = json['summary']
        @status = json['status']['name']
        @assign_id = json['assignee']['id'] unless json['assignee'].nil?
        @created = Time.parse(json['created']).localtime
        @updated = Time.parse(json['updated']).localtime
      end
    end
  end
end
