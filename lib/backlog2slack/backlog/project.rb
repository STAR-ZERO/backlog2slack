module Backlog2Slack
  module Backlog
    class Project
      attr_reader :id, :name

      def initialize(json)
        @id = json['id']
        @name = json['name']
      end
    end
  end
end

