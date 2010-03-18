require 'optparse'

module Alfred
  class Client

    def self.run(*args)
      new(*args).run
    end

    COMMANDS = %w{
      report
      server
    }

    def initialize(args = ARGV)
      @args = args
      @command = @args.shift
      @options = { # defaults
        :server => {
          :environment => :production
        }
      }
      validate_command
      setup_option_parser
    end

    def run
      begin
        @opt_parser.parse!(@args)

        case @command
        when 'server'
          $stdout.puts 'Starting Alfred server...'
          Alfred::App.run!(@options[:server])
        end
      rescue OptionParser::InvalidOption => error
        $stderr.puts "#{error}\n\n#{@opt_parser}"
      rescue OptionParser::MissingArgument => error
        $stderr.puts "#{error}\n\n#{@opt_parser}"
      end
    end

    private

    def validate_command
      # raise Alfred::CommandError unless COMMANDS.include?(@command)
      @args << '--help' unless COMMANDS.include?(@command)
    end

    # TODO: Split this up.
    def setup_option_parser
      @opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{File.basename($0)} <command> [options]"

        opts.separator ''
        opts.separator "Commands:\n" + COMMANDS.map { |c| "\t" + c }.join("\n")

        opts.separator ''
        opts.separator 'Options:'

        opts.on('--debug', 'Set $DEBUG to true') do |on_or_off|
          $DEBUG = on_or_off
        end

        opts.on_tail('-v', '--version', 'Show the version') do |v|
          puts "Alfred v#{Alfred::VERSION}"
          exit
        end

        opts.on_tail('--help', 'Show this help message') do
          puts opts
          exit
        end

        case @command
        when 'server'
          opts.on('-e', '--environment <environment>', 'Set the environment') do |env|
            @options[:server][:environment] = env
          end

          opts.on('-h', '--host <host>', 'Set the hostname') do |host|
            @options[:server][:host] = host
          end

          opts.on('-p', '--port <port>', 'Set the port') do |port|
            @options[:server][:port] = port
          end
        end
      end # OptionParser.new
    end # setup_option_parser

  end # Client
end # Alfred
