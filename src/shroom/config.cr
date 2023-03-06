module Shroom
  class Config
    include YAML::Serializable

    getter token : String
    getter channel : UInt64
    getter prefixes : Array(String)
    getter commands : Hash(String, String)
    getter help : String

    def initialize(@token : String, @channel : UInt64, @prefixes : Array(String), @commands : Hash(String, String), @help : String)
    end

    def self.load(filename)
      Totem.from_file(filename).mapping(Config)
    rescue ex : YAML::ParseException
      abort("Failed to parse #{filename}: #{ex.message}")
    end
  end
end
