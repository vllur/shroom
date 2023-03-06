require "totem"
require "discordcr"

require "./shroom/*"
require "./shroom/commands/*"
require "./shroom/actions/*"

module Shroom
  class Bot
    getter client : Discord::Client
    delegate run, to: client

    def initialize(config : Config)
      @client = Discord::Client.new(token: "Bot #{config.token}")
      Shroom.act_on_ready(client, config)
      Shroom.act_on_message(client, config)
    end
  end

  def self.run(config : Config)
    Bot.new(config).run
  end

  Shroom.run(Config.load("_config.yml"))
end
