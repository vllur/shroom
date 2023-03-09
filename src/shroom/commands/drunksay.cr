module Shroom
  def self.drunksay(client : Discord::Client, config : Config, channel_id : Discord::Snowflake)
    sentence = ""
    config.shitpost.shuffle.each do |element|
      sentence += " " + element.sample
    end

    client.create_message(channel_id, sentence)
  end
end
