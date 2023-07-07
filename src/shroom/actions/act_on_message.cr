module Shroom
  def self.act_on_message(client : Discord::Client, config : Config, classifier : Maschine::Bayes::BayesClassifier)
    client.on_message_create do |message|
      # First, train classifier on every message
      config.classifiers.each do |concept|
        if message.content.includes?(concept)
          classifier.train(concept, message.content)
        end
      end

      # Then skip if first word is not a bot prefix
      next unless config.prefixes.any? { |prefix| prefix == message.content.split(" ").first }

      command = message.content.split(" ")[1]
      message.content = message.content.split(" ").skip(1).join(" ")

      case command
      when config.commands["help"]
        Shroom.help(client, config, message.channel_id)
      when config.commands["eight_ball"]
        Shroom.eight_ball(client, config, message.channel_id)
      when config.commands["shitpost"]
        Shroom.shitpost(client, config, message.channel_id)
      when config.commands["drunksay"]
        Shroom.drunksay(client, config, message.channel_id)
      when config.commands["exchange"]
        Shroom.exchange(client, config, message)
      when config.commands["classify"]
        Shroom.classify(client, config, message, classifier)
      when config.commands["remind"]
        Shroom.remind(client, config, message)
      else
        if message.content.match(Regex.new(" #{config.commands["or"]} "))
          answer = message.content.split(config.commands["or"]).shuffle[0]
          client.create_message(message.channel_id, answer)
        end
      end
    end
  end
end
