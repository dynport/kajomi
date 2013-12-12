require "kajomi/http_client"
require "kajomi/entities"
require "digest/sha1"
require "base64"

module Kajomi
  class ApiClient
    attr_reader :shared_key, :secret_key, :options

    def initialize(shared_key, secret_key, options={})
      @shared_key = shared_key
      @secret_key = secret_key
      @options = options
    end

    def deliver_message(message)
      message_data = message.to_kajomi_hash
      response = http_client.post("api/json/basic/mailrelay/relay", message_data)
      parsed response
    end

    def get_lists
      response = http_client.get("api/json/basic/kjmservice/getLists")
      parsed(response).map do |hash|
        Kajomi::Entities::List.new(hash)
      end
    end

    def duplicate_list(list, title)
      data = {
        l: list.to_json,
        title: JSON.dump(title)
      }
      response = http_client.post("api/json/basic/kjmservice/duplicateList", data)
      Kajomi::Entities::List.new(parsed(response))
    end

    def query_users(list, field, value)
      data = {
        l: list.to_json,
        field: JSON.dump(field),
        value: JSON.dump(value)
      }
      response = http_client.post("api/json/basic/kjmservice/queryUsers", data)
      parsed_response = parsed(response)
      column_indexes = {
        uid: parsed_response["_columns"].index("uid"),
        firstname: parsed_response["_columns"].index("fname"),
        lastname: parsed_response["_columns"].index("lname"),
      }
      parsed_response.fetch("_rows").map do |row|
        Kajomi::Entities::User.new(uid: row[column_indexes[:uid]], lastname: row[column_indexes[:lastname]], firstname: row[column_indexes[:firstname]])
      end
    end

    def import_users(list, users=[])
      user_list = {
        name: "abonnenten",
        _columns: ["email", "fname", "lname"],
        _rows: users.map(&:to_array)
      }
      data = {
        l: list.to_json,
        t: JSON.dump(user_list)
      }
      response = http_client.post("api/json/basic/kjmservice/importUsers", data)
      parsed response
    end

    def remove_users(users=[])
      user_list = {
        name: "users",
        _columns: ["uid"],
        _rows: users.map { |user| [user.uid] }
      }
      data = {
        t: JSON.dump(user_list)
      }
      response = http_client.post("api/json/basic/kjmservice/removeUsers", data)
    end

  protected
    def http_client
      @http_client ||= build_http_client
    end

    def build_http_client
      client = HttpClient.new(options)
      client.add_header("sessid", generate_session_id)
      client
    end

    def generate_session_id
      Base64.encode64(Digest::SHA1.digest("#{secret_key}#{random_secret}")).chop
    end

    def random_secret
      response = HttpClient.new(options).get("auth/#{shared_key}")
    end

    def parsed(response)
      JSON.parse(response)
    end
  end
end
