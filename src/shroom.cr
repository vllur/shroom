require "totem"

config = Totem.from_file "_config.yml"

p! config.get("token")
p! config.get("channel")
p! config.get("prefixes")
