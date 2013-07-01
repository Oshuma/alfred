# Alfred

Simple system monitoring app.

## Setup

Clone the app:

    $ git clone git://github.com/Oshuma/alfred.git

Create <tt>config/alfred.yml</tt> and <tt>config/commands.yml</tt> files (see the examples).

Run the server:

    $ rackup

Once the server is up, you can either hit the web URL or the JSON API:

    $ curl http://example.com:9292/api/commands.json

The response will look like this:

    [
      {
        "id": "command_id",
        "name": "Command Name",
        "output": "Un-escaped command output.\nThis also includes newlines.",
      },

      ...
    ]
