require "json"

module Kajomi
  module Entities
    class List < Base
      attr_accessor :listnum,
        :replytoemail,
        :replytoname,
        :sende,
        :sendn,
        :title

      def initialize(attrs={})
        attrs.each do |key, value|
          self.send(:"#{key}=", value)
        end
      end

      def to_json
        MultiJson.dump({
          listnum: @listnum,
          title: @title,
          sende: @sende,
          sendn: @sendn,
          replytoemail: @replytoemail,
          replytoname: @replytoname
        })
      end
    end
  end
end
