module Shroom
  def self.classify(client : Discord::Client, config : Config, message : Discord::Message, classifier : Maschine::Bayes::BayesClassifier)
    client.create_message(message.channel_id, classifier.classify(message.content))
  end
end
