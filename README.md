# Alfred

Simple system monitoring app.

## Setup

Clone the app:

    $ git clone git://github.com/Oshuma/alfred.git

Create <tt>config/alfred.yml</tt> and <tt>config/commands.yml</tt> files (see the examples).

You must enable either the web interface or the JSON API (or both), since they default to `false`.

To enable the web interface, set `enable_web` to `true` in `config/alfred.yml`.

To enable the JSON API, set `enable_api` to `true` in `config/alfred.yml`, then use it like so:

    $ curl -H 'X-AUTH-TOKEN: your_auth_token' http://example.com:9292/api/commands.json

The response will look like this:

    [
      {
        "id": "command_id",
        "name": "Command Name",
        "output": "Un-escaped command output.\nThis also includes newlines.",
      },

      ...
    ]

Run the server:

    $ rackup
