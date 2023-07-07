<img align="left" height="120px" width="80px" src="/logo.svg">

<h1>shroom</h1>

<p>
<a href="https://github.com/crystal-lang/crystal"><img src="https://img.shields.io/badge/language-crystal-776791.svg"/></a>
<a href="https://github.com/vllur/shroom/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-%20GPL--3.0-blue"/></a>
</p>

<p>
General purpose Discord bot, focused on bringing functionality to your server. Ask about anything, let it remind you about scheduled tasks or check currency exchanges.
</p>
<p></p>

<img src="screenshot.png">

<!-- TOC -->

- [Installation](#installation)
  - [Configuration](#configuration)
  - [Running with Docker](#running-with-docker)
  - [Running with Crystal](#running-with-crystal)
- [Usage](#usage)
  - [Customization](#customization)
  - [Commands](#commands)
    - [help](#help)
    - [shitpost](#shitpost)
    - [drunksay](#drunksay)
    - [eight_ball](#eight_ball)
    - [exchange](#exchange)
    - [classify](#classify)
    - [remind](#remind)
    - [or](#or)
- [Development](#development)
  - [Project structure](#project-structure)
  - [Adding a command](#adding-a-command)
  - [Making a Pull Request](#making-a-pull-request)
- [FAQ](#faq)
- [Contributors](#contributors)

<!-- /TOC -->

## Installation

### Configuration

First, you need to obtain [Discord API](https://discord.com/developers/applications) token and [ID](https://support.discord.com/hc/en-us/articles/206346498-Where-can-I-find-my-User-Server-Message-ID-) of main (or #random, etc.) channel in your Discord server. You will also need to add a bot to your application and get its Application ID.

Then click `Download` and `Download ZIP` at the top of this page, or type `git clone https://github.com/vllur/shroom.git` in terminal.

Now you can copy Discord API token and channel ID to `_config.yml`:

```yaml
# Discord token
token: "TOKEN"

# Channel ID 
channel: 123
```

Next, to add your bot to server go to <a href="https://discord.com/oauth2/authorize?client_id=APPLICATION-ID&scope=bot&permissions=8">https://discord.com/oauth2/authorize?client_id=APPLICATION-ID&scope=bot&permissions=8</a> address in your browser, substituting APPLICATION-ID with your bot's Application ID.

You probably want to further edit `_config.yml` to configure the bot to your liking.

### Running with Docker

You only need to have `docker` and `docker-compose` commands available. Then simply:

```sh
docker-compose up --build
```

### Running with Crystal

If you have Crystal installed:

```sh
shards install
shards build
./bin/shroom
```

Optimized binary can be produced by adding `--release` and `--no-debug` flags to build command. This is a good method for smaller servers, as ~30 MB will be sufficient for the bot process.

Alternatively:

```sh
shards install
crystal ./src/shroom.cr
```

## Usage

### Customization

Bot reacts on every chat it sees and have write access to, if message begins with `prefix`. Names of commands are customizable.

Configuration in `_config.yml`:

```yml
prefixes:
- "!shroom"
- "shroom"

commands:
  help: "help"
  shitpost: "shitpost"
  drunksay: "drunksay"
  exchange: "exchange"
  eight_ball: "8ball"
  classify: "classify"
  remind: "remind"
  or: "or"
```

You can add or remove prefixes, and customize or translate the commands names. For example, whenever this documentation refers to `shroom help`, if you set `help: "pomoc"`, bot will react to `shroom pomoc`. Similarly, by adding `- "bot"` to `prefixes`, you can use `bot pomoc`.

Every configuration change needs a bot restart.

### Commands

Currently available commands:

- `help` - writes a brief help message
- `shitpost` - generates a random shitpost
- `drunksay` - generates a shuffled shitpost
- `eight_ball` - answers given question with configured answers
- `exchange` - converts between currencies and crypto
- `classify` - decides which configured answers suit the input best
- `remind` - reminds you about something after a specified amount of time

#### help

Usage example:

```
shroom help
```

Configuration in `_config.yml`:

```yml
help: "**Commands**:\n
- `help`: Displays this message\n
- `shitpost`: Generates a random shitpost\n
- `drunksay`: Generates a drunk shitpost\n
- `eight_ball`: Answers given question\n
- `exchange`: Convert between currencies and crypto\n
- `classify`: Picks best way to describe your input\n
- `remind`: Reminds you about something after a specified amount of time\n
\n
**Features**:\n
- `or`: Chooses between two or more options\n
\n
**Code and documentation:**\n
https://github.com/vllur/shroom"
```

Customizing this string will alter the help message. You can add additional information or entirely replace it.

#### shitpost

Usage example:

```
shroom shitpost
```

Configuration in `_config.yml`:

```yml
shitpost:
-
  - "Gentelmen,"
  - "*EKHEM*!"
-
  - "someone once said something about"
  - "Sun Tzu wrote in Art of War, that"
-
  - "mushrooms being better than animals"
  - "I don't know what I'm talking about"
-
  - "and thats an undeniable fact."
  - "which even can be seen in the wall paintings in Lasco!"
```

Table of String tables. From each table one random element is picked, space is glued and next one is added.

#### drunksay

Usage example:

```
shroom drunksay
```

Same as [shitpost](#shitpost), but the order is random.

#### eight_ball

Usage example:

```
shroom eight_ball should I practice today?
```

Configuration in `_config.yml`:

```yml
responses:
- "Yes"
- "No"
- "Maybe"
- "Ask me later"
- "I don't know"
```

Table of Strings. One random element is choosen as the answer.

#### exchange

Usage example:

```
shroom exchange
shroom exchange pln
shroom exchange 2 eur
shroom exchange 4 eur to usd
```

Configuration in `_config.yml`:

```yml
exchange:
  to: "to"
  input_amount: 1
  input_currency: "EUR"
  output_currency: "USD"
```

`to` parameter is a separator in command. Rest are default values to send to API when user have't passed them.

The command utilizes [https://api.exchangerate.host/](https://api.exchangerate.host) API. It supports conventional currencies and crypto. If output amound is greater or equals `0.01`, it is rounded to 2 decimal places. Otherwise full answer is given.

#### classify

Usage example:

```
shroom classify likes milk and warm places
```

Configuration in `_config.yml`:

```yml
classifiers:
- "cat"
- "dog"
```

Table of Strings. [Maschine](https://github.com/gundy818/maschine) shard is used for the algorithm. On every message sent to channel the bot can see, it associates content with one of classifiers, if present. Then you can ask what the bot associates it with.

#### remind

Usage example:

```
shroom remind 2 h Go excercise
shroom remind me in 2 minutes Make tea 
```

Configuration in `_config.yml`:

```yml
remind:
  omit:
    - "me"
    - "in"
  confirmation:
    - "OK"
  seconds:
    - "seconds"
    - "sec"
    - "s"
  minutes:
    - "minutes"
    - "min"
    - "m"
  hours:
    - "hours"
    - "h"
```

`omit` words are completely ignored. `confirmation` takes one response at random to indicate successful set of the timer. `seconds`, `minutes` and `hours` are localizations and abbreviations of time units. Bot will spawn a new process, which waits for specified amount of time and pings you with your message.

### or

Usage example:

```
shroom one or two
shroom one or two or three or four
```

This command is meant to be in the middle of a message without command. It will separate the message and return one choice as an answer.

## Development

Issues and pull requests are welcome! Make sure to first post an issue to discuss your ideas before commiting to fully making a feature.

### Project structure

```
├── _config.yml
├── shard.lock
├── shard.yml
├── spec
│   └── [...]
└── src
    ├── shroom
    │   ├── actions
    │   │   ├── act_on_message.cr
    │   │   ├── act_on_ready.cr
    │   │   └── [...]
    │   ├── commands
    │   │   ├── help.cr
    │   │   └── [...]
    │   └── config.cr
    └── shroom.cr
```

- `_config.yml` - holds all configuration, translatable strings and messages
- `src/shroom.cr` - main file, holds `Bot` class and runs the bot
- `src/config.cr` - `Config` class is responsible for loading configuration
- `src/actions/*` - each file represents actions to be taken on certain event, exposed by `Discordcr`
- `src/commands/*` - one bot command per file

### Adding a command

Adding new command is quite simple. First, think about a name and configuration options your command might want to have. For example, in `config_yml`:

```yaml
commands:
  [...]
  my_command: "my_command"

[...]

my_command: "test!"
```

Next, lets load the configuration. Open `shroom/config.cr` and add following to the rest of getters:

```crystal
getter my_command : String
```

In the `initialize` function declaration also add the parameter:

```crystal
[...], @my_command : String, [...]
```

Next, register your command in `shroom/actions/act_on_message.cr`:

```crystal
when config.commands["my_command"]
  Shroom.my_command()
```

You can pass anything your command will need to this function. For example, `client`, `config` or `message`.

Now to create the file to hold your code - `shroom/commands/my_command.cr`:

```crystal
module Shroom
  def self.my_command()
    puts "Test!"
  end
end
```

And if you rerun (or recompile), you will notice that writing `shroom my_command` in Discord chat results in `Test!` in terminal output.

### Making a Pull Request

1. Make a fork (<https://github.com/vllur/shroom/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request

## FAQ

- `Q`: Configuration file is present, but the bot can't find it, what's wrong?
- `A`: Configurations location is relative to current working directory, so `cd` first to where your configuration is.

## Contributors

- [vllur](https://github.com/vllur) - creator and maintainer
