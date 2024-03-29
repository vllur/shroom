module Shroom
  class Config
    include YAML::Serializable

    getter token : String
    getter channel : UInt64
    getter prefixes : Array(String)
    getter commands : Hash(String, String)
    getter shitpost : Array(Array(String))
    getter exchange : Hash(String, String)
    getter responses : Array(String)
    getter classifiers : Array(String)
    getter remind : Hash(String, Array(String))
    getter? enable_hello : Bool
    getter hello : String
    getter help : String

    def initialize(@token : String, @channel : UInt64, @prefixes : Array(String), @commands : Hash(String, String), @shitpost : Array(Array(String)), @exchange : Hash(String, String), @responses : Array(String), @classifiers : Array(String), @remind : Hash(String, Array(String)), @enable_hello : Bool, @hello : String, @help : String)
    end

    def self.load(filename)
      Totem.from_file(filename).mapping(Config)
    rescue ex : YAML::ParseException
      abort("Failed to parse #{filename}: #{ex.message}")
    end
  end
end
