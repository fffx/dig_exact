Struct.class_eval do
  def dig_exact(key, *args)
    value = if key.respond_to?(:to_sym)
              return nil unless self.respond_to?(key.to_sym)
              self.send(key.to_sym)
            elsif key.respond_to?(:to_int)
              return nil unless self.length >= key.to_int + 1
              self[key.to_int]
            else
              raise TypeError, "no implicit conversion of #{key.class} into Integer"
            end

    return value if args.length == 0
    return nil unless value.respond_to? :dig_exact
    value.dig_exact(*args)
  end
end