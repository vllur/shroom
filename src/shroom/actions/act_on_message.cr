module Shroom
  def self.act_on_message(client : Discord::Client, config : Config)
    client.on_message_create do |message|
      # Act only on a message where first word is a prefix
      next if message.content.empty? || !config.prefixes.join(" ").match(Regex.new(message.content.split(" ").first))

      # Second word is the command
      case message.content.split(" ")[1]
      when config.commands["help"]
        client.create_message(message.channel_id, "TODO")
      end
    end
  end
end
