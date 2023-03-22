require "totem"
require "discordcr"
require "http/client"
require "json"
require "maschine"

require "./shroom/*"
require "./shroom/commands/*"
require "./shroom/actions/*"

module Shroom
  class Bot
    getter client : Discord::Client
    getter classifier : Maschine::Bayes::BayesClassifier
    delegate run, to: client

    def initialize(config : Config)
      @client = Discord::Client.new(token: "Bot #{config.token}")
      @classifier = Maschine::Bayes::BayesClassifier.new(config.classifiers)
      Shroom.act_on_ready(client, config)
      Shroom.act_on_message(client, config, classifier)
    end
  end

  def self.run(config : Config)
    Bot.new(config).run
  end

  Shroom.run(Config.load("_config.yml"))
end
