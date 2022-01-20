module WysiwygHelper
  def wysiwyg_class
    "wysiwyg prose"
  end

  def prism_theme_css
    "https://cdnjs.cloudflare.com/ajax/libs/prism-themes/1.9.0/prism-dracula.min.css"
  end

  def generate_wysiwyg_id
    SecureRandom.uuid
  end
end
