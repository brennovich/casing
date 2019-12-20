module Casing
  class Pascal
    module String
      def self.call(val, include_values: nil, symbol_to_string: nil)
        include_values = include_values.nil? ? true : include_values
        symbol_to_string ||= false

        return val unless include_values
        return val if val.length == 0

        cached_val = cache(symbol_to_string)[val]
        return cached_val if not cached_val.nil?

        sym = val.is_a?(Symbol)

        converted = val
          .to_s
          .gsub(/\/(.?)/) { "::" + $1.upcase }
          .gsub(/(^|_)(.)/) { $2.upcase }

        if !symbol_to_string && sym
          converted = converted.to_sym
        end

        cache(symbol_to_string)[val] = converted

        converted
      end
      class << self; alias :! :call; end # TODO: Remove deprecated actuator [Kelsey, Thu Oct 08 2015]

      def self.cache(symbol_to_string)
        if symbol_to_string
          return symbol_to_string_cache
        else
          return raw_cache
        end
      end

      def self.symbol_to_string_cache
        @symbol_to_string_cache ||= ::Hash.new
      end

      def self.raw_cache
        @raw_cache ||= ::Hash.new
      end
    end
  end
end
