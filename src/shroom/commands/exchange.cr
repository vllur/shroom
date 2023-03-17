module Shroom
  def self.exchange(client : Discord::Client, config : Config, message : Discord::Message)
    # Make array from input and remove command name
    data = message.content.split(" ").skip(1)
    # Filter out separator
    data.delete(config.exchange["to"])
    api = "https://api.exchangerate.host/convert"

    # Setting to nil first will allow to give partial data as input
    input_amount = nil
    input_currency = nil
    output_currency = nil

    # First two occurences of currence codes and first number will be accepted
    data.each do |entry|
      if entry =~ /^[a-zA-Z]{3}$/
        if input_currency.nil?
          input_currency = entry
        elsif output_currency.nil?
          output_currency = entry if output_currency.nil?
        end
      elsif input_amount.nil?
        input_amount = entry
      end
    end

    # Set values from config if they were not given in input
    input_amount = config.exchange["input_amount"] if input_amount.nil?
    output_currency = config.exchange["output_currency"] if output_currency.nil?
    input_currency = config.exchange["input_currency"] if input_currency.nil?

    call = api + "?from=" + input_currency + "&to=" + output_currency + "&amount=" + input_amount
    reply = HTTP::Client.get(call).body
    result = JSON.parse(reply)["result"]

    # 0.00 answer is not very helpful
    if result.as_f > 0.01
      result = result.to_s[0..3]
    end

    client.create_message(message.channel_id, "`#{input_amount} #{input_currency.upcase} = #{result} #{output_currency.upcase}`")
  end
end
