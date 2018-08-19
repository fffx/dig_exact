
Array.class_eval do
  def dig_exact(key, *args)
    value = self.at(key)
    return value if args.length == 0
    return nil unless value.respond_to? :dig_exact
    value.dig_exact(*args)
  end
end
