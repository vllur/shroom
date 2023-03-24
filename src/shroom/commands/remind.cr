module Shroom
  def self.remind(client : Discord::Client, config : Config, message : Discord::Message)
    # Omit command and defined words
    data = message.content.split(" ").skip(1) - config.remind["omit"]

    # TODO: support shorthand time, eg. 3h
    amount = data[0].to_i
    unit = data[1]

    # Omit time amount and unit
    about = message.author.mention + " " + data[2..].join(" ")

    client.create_message(message.channel_id, config.remind["confirmation"].sample)

    if config.remind.["seconds"].index(unit) != nil
      spawn do
        sleep amount.seconds
        client.create_message(message.channel_id, about)
      end
    elsif config.remind.["minutes"].index(unit) != nil
      spawn do
        sleep amount.minutes
        client.create_message(message.channel_id, about)
      end
    elsif config.remind.["hours"].index(unit) != nil
      spawn do
        sleep amount.hours
        client.create_message(message.channel_id, about)
      end
    end
  end
end
