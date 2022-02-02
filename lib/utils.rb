module Utils
  # a_b_c -> ENV[A_B_C] -> credentials[:a_b_c]
  # a.b_c -> ENV[A__B_C] -> credentials[:a][:b_c]
  def self.env_or_credential(key, default = nil)
    env_key = key.upcase.gsub ".", "__"
    res = ENV[env_key]
    return res if res.present?

    splited_keys = key.downcase.split "."
    res = splited_keys.inject(Rails.application.credentials) { |o, k| o&.public_send k }
    return res if res.present?

    raise "Require #{key} is set in env or credentials." if default.nil?

    default
  end
end
