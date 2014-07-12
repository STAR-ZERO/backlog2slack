module Backlog2Slack
  module Backlog
    class User
      attr_reader :id, :name, :mail

      def initialize(json)
        @id = json['id']
        @name = json['name']
        @mail = json['mailAddress']
      end

      def to_s
        "id:#{@id} name:#{@name} mail:#{@mail}"
      end
    end
  end
end

