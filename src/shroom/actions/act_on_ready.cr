module Shroom
  def self.act_on_ready(client : Discord::Client, config : Config)
    client.on_ready do
      client.create_message(config.channel, "Hello")
    end
  end
end
