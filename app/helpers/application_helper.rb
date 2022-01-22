module ApplicationHelper
  def ga_measurement_id
    Utils.env_or_credential "ga_measurement_id", ""
  end
end
