require 'ostruct'

OpenStruct.class_eval do
  def dig_exact(name, *args)
    begin
      name = name.to_sym
    rescue NoMethodError
      raise TypeError, "#{name} is not a symbol nor a string"
    end
    return nil unless self.respond_to?(name)
    value = self.send(name)

    return value if args.length == 0
    return nil unless value.respond_to? :dig_exact

    value.dig_exact(*args)
  end
end