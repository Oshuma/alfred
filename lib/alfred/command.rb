require 'yaml'

module Alfred
  class Command

    attr_accessor :name
    attr_reader :id, :raw

    def self.all
      raise 'No commands loaded.' unless commands
      commands
    end

    def self.commands
      defined?(@@commands) ? @@commands : nil
    end

    def self.exec(raw_string)
      new('Command', raw_string).exec!
    end

    def self.find(id)
      commands.select { |command| command.id == id }.first
    end

    # Load an array of Commands from a YAML file.
    def self.load_yaml!(command_file)
      @@commands = []
      YAML.load_file(command_file).each { |c| @@commands << new(c) }
      @@commands
    end

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
