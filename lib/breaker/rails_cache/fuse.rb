module Breaker
  module RailsCache
    class Fuse
      DATA_ATTRS = [:state, :failure_threshold, :retry_timeout, :timeout, :retry_threshold]
      attr_accessor :name

      def initialize(name)
        self.name = name
        self.state ||= defaults[:state]
        self.failure_threshold ||= defaults[:failure_threshold]
        self.retry_timeout ||= defaults[:retry_timeout]
        self.timeout ||= defaults[:timeout]
        self.failure_count ||= defaults[:failure_count].to_i
        self.retry_threshold ||= defaults[:retry_threshold]
      end

      def defaults
        Repo.config
      end

      def update(attributes)
        attributes.each do |attr, value|
          set_value(attr,value)
        end
      end

      def ==(other)
        other.instance_of?(self.class) && name == other.name
      end

      def set_value(key, value)
        Rails.cache.write(key_name(key), value)
      end

      def get_value(key)
        Rails.cache.read(key_name(key))
      end
      def inc_value(key, value, ttl=nil)
        options = {}
        options[:ttl] = ttl if ttl
        Rails.cache.increment(key_name(key), value, options)
      end

      def key_name(key)
        "BREAKER_#{self.name}_#{key}"
      end

      def failure_count
        get_value(:failure_count).to_i
      end

      def failure_count=(value)
        value = value.to_i
        if value.zero?
          Rails.cache.write(key_name(:failure_count), value, raw: true)
        else
          inc_value(:failure_count, 1)
        end
      end

      DATA_ATTRS.each do |fuse_key|
        define_method fuse_key do
          get_value(fuse_key)
        end

        define_method "#{fuse_key}=" do |value|
          set_value(fuse_key, value)
        end
      end
    end
  end
end
