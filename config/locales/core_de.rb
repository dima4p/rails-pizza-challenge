# frozen_string_literal: true

{
  de: {
    number: {
      nth: {
        ordinals: lambda do |_key, options|
          '.'
        end,

        ordinalized: lambda do |_key, options|
          number = options[:number]
          "#{number}#{ActiveSupport::Inflector.ordinal(number)}"
        end
      }
    }
  }
}
