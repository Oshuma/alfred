if false
    COMMANDS = %w[
      disk_usage
      memory
      uptime
      users
    ]
end

module Alfred
  class Command

    class << self
      # TODO: Sanitize the +raw_string+ input.
      def exec(raw_string)
        %x[#{raw_string}].chomp
      end
    end

  end
end
