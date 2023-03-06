module Shroom
  def self.act_on_message(client : Discord::Client, config : Config)
    client.on_message_create do |message|
      # Only when first word is a prefix
      next if message.content.empty? || !config.prefixes.join(" ").match(Regex.new(message.content.split(" ").first))

      command = message.content.split(" ")[1]
      message.content = message.content.split(" ").skip(1).join(" ")

      case command
      when config.commands["help"]
        client.create_message(message.channel_id, Shroom.help(config))
      else
        if message.content.match(Regex.new(" #{config.commands["or"]} "))
          answer = message.content.split(config.commands["or"]).shuffle[0]
          client.create_message(message.channel_id, answer)
        end
      end
    end
  end
end