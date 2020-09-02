module LegacyHelpers
  %i[get post patch put delete head].each do |verb|
    define_method(verb) do |path, options = {}|
      super(path, options[:params], options[:headers])
    end
  end
end
