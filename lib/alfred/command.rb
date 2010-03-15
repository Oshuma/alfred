require 'yaml'

module Alfred
  class CommandError < StandardError; end

  class Command

    attr_accessor :name
    attr_reader :raw

    class << self
      def exec(raw_string)
        new('Command', raw_string).exec!
      end

      # Return an array of Commands, read from a YAML file.
      def from_yaml(command_file)
        commands = []
        YAML.load_file(File.expand_path(command_file)).each do |cmd|
          commands << new(cmd['name'], cmd['exec'])
        end
        commands
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

    def output
      exec! if @output.nil?
      @output
    end

  end # Command
end # Alfred
