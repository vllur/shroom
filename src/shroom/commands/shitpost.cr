module Shroom
  def self.shitpost(client : Discord::Client, config : Config, channel_id : Discord::Snowflake)
    sentence = ""
    config.shitpost.each do |element|
      sentence += " " + element.sample
    end

    client.create_message(channel_id, sentence)
  end
end
