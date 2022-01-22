require "rails/generators/erb/scaffold/scaffold_generator"
require "rails/generators/resource_helpers"

module Ellie
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      include Rails::Generators::ResourceHelpers

      source_root File.expand_path("templates", __dir__)

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def create_root_folder
        empty_directory File.join("app/views", controller_file_path)
      end

      def views
        paths = Dir[File.join(File.expand_path("templates", __dir__), "/*")]
        names = paths.map do |path|
          File.basename(path, ".html.erb.tt")
        end

        reject_list = %w[index_partial partial]
        names.reject do |name|
          reject_list.include? name
        end
      end

      def copy_view_files
        views.each do |view|
          formats.each do |format|
            filename = filename_with_extensions(view, format)
            template filename, File.join("app/views", controller_file_path, filename)
          end
        end

        template "index_partial.html.erb",
                 File.join("app/views", controller_file_path, "_index_#{singular_table_name}.html.erb")
        template "partial.html.erb", File.join("app/views", controller_file_path, "_#{singular_table_name}.html.erb")
      end

      def view_i18n_scope
        @view_i18n_scope ||= route_url.tr("/", ".").gsub(/\A./, "")
      end

      private

      def available_views
        %w[index edit show new _form]
      end
    end
  end
end
