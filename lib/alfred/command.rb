if false
    COMMANDS = %w[
      disk_usage
      memory
      uptime
      users
    ]
end

module Alfred
  class CommandError < StandardError; end

  class Command

    attr_accessor :name
    attr_reader :raw, :output

    class << self
      def exec(raw_string)
        new('Command', raw_string).exec!
      end
    end # self

    # Use as such:
    #
    #   Command.new('Host', 'hostname')
    #   # ..or..
    #   Command.new({ :name => 'Host', :exec => 'hostname' })
    #
    # TODO: Sanitize the @raw input.
    def initialize(*args)
      if args.first.is_a?(Hash)
        options = args.first
        @name = options[:name]
        @raw  = options[:exec]
      else
        @name = args[0]
        @raw  = args[1]
      end
      raise Alfred::CommandError unless @raw
    end

    def exec!
      @output = %x[ #{@raw} ].chomp
    end

  end # Command
end # Alfred
