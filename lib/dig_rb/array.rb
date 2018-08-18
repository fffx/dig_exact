unless Array.instance_methods.include?(:dig)
  Array.class_eval do
    def dig(key, *args)
      value = self.at(key)
      return value if args.length == 0 || value.nil?
      DigRb.guard_dig(value)
      value.dig(*args)
    end
  end
end

Array.class_eval do
  def dig_exact(key, *args)
    value = self.at(key)
    return value if args.length == 0
    return nil unless value.respond_to? :dig_exact
    value.dig_exact(*args)
  end
end
