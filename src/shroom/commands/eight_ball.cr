module Shroom
  def self.eight_ball(client : Discord::Client, config : Config, channel_id : Discord::Snowflake)
    client.create_message(channel_id, config.responses.sample)
  end
end
