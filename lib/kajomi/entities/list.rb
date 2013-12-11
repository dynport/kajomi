module Kajomi
  module Entities
    class List < Base
      attr_accessor :id,
        :reply_to_email,
        :reply_to_name,
        :sender_email,
        :sender_name,
        :title

      def initialize(attrs={})
        @id = attrs.fetch("listnum", nil)
        @reply_to_email = attrs.fetch("replytoemail", nil)
        @reply_to_name = attrs.fetch("replytoname", nil)
        @sender_name = attrs.fetch("sendn", nil)
        @sender_email = attrs.fetch("sende", nil)
        @title = attrs.fetch("title", nil)
      end
    end
  end
end
