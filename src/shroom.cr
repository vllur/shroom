require "totem"
require "discordcr"

module Shroom
  struct Config
    include JSON::Serializable

    property token : String
    property channel : UInt64
    property prefixes : Array(String)
    property commands : Hash(String, String)
  end

  config = Totem.from_file("_config.yml").mapping(Config)
  client = Discord::Client.new(token: "Bot #{config.token}")

  client.on_ready do
    client.create_message(config.channel, "Hello")
  end

  client.on_message_create do |message|
    # Act only on a message where first word is a prefix
    next if message.content.empty? || !config.prefixes.join(" ").match(Regex.new(message.content.split(" ").first))

    # Second word is the command
    case message.content.split(" ")[1]
    when config.commands["help"]
      client.create_message(message.channel_id, "TODO")
    end
  end

  client.run
end
