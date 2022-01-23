# Monkey patch for use hashid to dom_id.
module ActionView
  module RecordIdentifier
    private

    def record_key_for_dom_id(record)
      model = convert_to_model(record)
      key = model.class.ancestors.include?(HashidSluggable) ? [model.hashid] : model.to_key
      key ? key.join(JOIN) : key
    end
  end
end

module HashidSluggable
  extend ActiveSupport::Concern

  class_methods do
    def hashids
      salt = table_name
      salt += Rails.application.secret_key_base if Rails.env.production?
      # Set max length to 4 to prevent duplication with xxx_new_path.
      @hashids ||= Hashids.new(salt, 4)
    end
  end

  included do
    validates :hashid, uniqueness: true
    after_create :generate_hashid_if_blank!
  end

  def to_param
    hashid
  end

  private

  def generate_hashid_if_blank!
    raise "create_hashid_if_blank! required id present." if id.blank?
    return if hashid.present?

    self.hashid = self.class.hashids.encode(id)
    save!
  end
end
