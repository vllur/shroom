<img align="left" height="120px" width="80px" src="/logo.svg">

<h1>shroom</h1>

<p>
<a href="https://github.com/crystal-lang/crystal"><img src="https://img.shields.io/badge/language-crystal-776791.svg"/></a>
</p>

General purpose Discord bot, written in Crystal.

<!-- TOC -->

- [Installation](#installation)
- [Usage](#usage)
- [Development](#development)
  - [Environment](#environment)
  - [Project structure](#project-structure)
- [Contributing](#contributing)
- [Contributors](#contributors)

<!-- /TOC -->

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here

## Development

### Environment

You need to have [Crystal](https://github.com/crystal-lang/crystal) and git installed. Then clone the repo:

```sh
git clone https://github.com/vllur/shroom.git
cd shroom
```

Get [Discord API](https://discord.com/developers/applications) token and  [ID](https://support.discord.com/hc/en-us/articles/206346498-Where-can-I-find-my-User-Server-Message-ID-) of main channel in your guild. Copy them to `_config.yml`:

```yaml
# Discord token
token: "TOKEN"

# Channel ID 
channel: 123
```

Configuration file is relative to your current working directory.

To install dependencies:

```sh
shards install
```

Now you can add your bot to the server and run:

```sh
crystal ./src/shroom.cr
```

You can also compile the binary and then run it:

```sh
mkdir build
crystal build ./src/shroom.cr -o ./build/shroom
./build/shroom
```

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
- `src/config.cr` -  `Config` class is responsible for loading configuration
- `src/actions/*` - each file represents actions to be taken on certain event, exposed by `Discordcr`
- `src/commands/*` - one bot command per file

## Contributing

1. Fork it (<https://github.com/vllur/shroom/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [vllur](https://github.com/vllur) - creator and maintainer
