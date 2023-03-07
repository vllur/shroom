module Shroom
  def self.help(client : Discord::Client, config : Config, channel_id : Discord::Snowflake)
    client.create_message(channel_id, config.help)
  end
end
