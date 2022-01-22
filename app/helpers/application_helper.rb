module ApplicationHelper
  def ga_measurement_id
    Utils.env_or_credential "ga_measurement_id", ""
  end

  # Usage:
  # activerecord.enums.foo.bar.[keys]
  # options_for_select_with_i18n(Foo, :bars)
  def options_for_select_with_i18n(model_class, options_key)
    model_class.public_send(options_key.to_s.pluralize).keys.map do |key|
      label = t "activerecord.enums.#{model_class.model_name.i18n_key}.#{options_key.to_s.singularize}.#{key}"
      [label, key]
    end
  end

  # Usage:
  # activerecord.enums.foo.bar.baz
  # options_for_select_with_i18n(Foo, :bar, :baz)
  def enum_t(model_class, enum_type, enum_name)
    t "activerecord.enums.#{model_class.model_name.i18n_key}.#{enum_type.to_s.singularize}.#{enum_name}"
  end
end
