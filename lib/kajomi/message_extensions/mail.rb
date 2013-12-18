module Mail
  class Message
    def html?
      content_type && content_type.include?("text/html")
    end

    def body_text
      if text_part.nil?
        body.to_s unless html?
      else
        text_part.body.to_s
      end
    end

    def body_html
      if html_part.nil?
        body.to_s if html?
      else
        html_part.body.to_s
      end
    end

    def to_kajomi_hash
      recipients = []
      [:to, :cc].each do |type|
        self.send(type).each do |recipient|
          recipients << {
            "address" => recipient,
            "type" => "#{type.to_s}".upcase
          }
        end unless self.send(type).nil?
      end

      message = {
        "_custom_header" => [],
        "content" => self.body_text,
        "htcontent" => self.body_html,
        "description" => "",
        "fattach" => "",
        "replyto" => nil,
        "senderemail" => "",
        "sendername" => "",
        "subject" => self.subject
      }

      options = {
        "sender" => MultiJson.dump(self['from'].to_s),
        "_m" => MultiJson.dump(recipients),
        "m" => MultiJson.dump(message)
      }

      options
    end
  end
end


