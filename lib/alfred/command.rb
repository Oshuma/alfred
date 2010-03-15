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

    class << self
      # TODO: Sanitize the +raw_string+ input.
      def exec(raw_string)
        %x[#{raw_string}].chomp
      end
    end # self

    attr_accessor :name
    attr_reader :raw

    # Use as such:
    #
    #   Command.new('Host', 'hostname')
    #   # ..or..
    #   Command.new({ :name => 'Host', :exec => 'hostname' })
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

  end # Command
end # Alfred
