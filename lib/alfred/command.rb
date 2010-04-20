require 'yaml'

module Alfred
  class Command

    mattr_accessor :commands

    attr_accessor :name
    attr_reader :id, :raw

    class << self
      def exec(raw_string)
        new('Command', raw_string).exec!
      end

      def all
        raise 'No commands loaded.' unless self.commands
        self.commands
      end

      # Return an array of Commands, read from a YAML file.
      def from_yaml(command_file)
        commands = []
        YAML.load_file(File.expand_path(command_file)).each do |command|
          commands << new(command)
        end
        commands
      end

      # Loads the commands in +command_file+ into a class variable.
      # (see Command.from_yaml)
      def load_from_yaml(command_file)
        @@commands = from_yaml(command_file)
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
        @name = options[:name] || options['name']
        @raw  = options[:exec] || options['exec']
        @id   = options[:id]   || options['id']
      else
        @name = args[0]
        @raw  = args[1]
        @id   = args[2]
      end
      raise Alfred::CommandError unless @name && @raw
      generate_id unless @id
    end

    def exec!
      @output = %x[ #{@raw} ]
    end

    def output
      exec! if @output.nil?
      @output
    end

    private

    def generate_id
      @id = @name.gsub(/\s/, '_').downcase
    end

  end # Command
end # Alfred
