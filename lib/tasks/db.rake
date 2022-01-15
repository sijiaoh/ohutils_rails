namespace :db do # rubocop:disable Metrics/BlockLength
  id = Rails.application.class.module_parent.name.downcase

  def mysql_in_docker!(command)
    system("bundle exec mysql_in_docker #{command}") || abort("Command failed.")
  end

  task start: :environment do
    database_config = Rails.configuration.database_configuration[Rails.env]
    port = database_config["port"] || 3306
    password = database_config["password"]
    mysql_in_docker! "start #{id} 8 #{port} #{password}"
  end

  task stop: :environment do
    mysql_in_docker! "stop #{id}"
  end

  task remove: :environment do
    mysql_in_docker! "remove #{id}"
  end

  task migrate_from_old_service: :environment do
    user = User.first
    space = Space.first

    raise "Require an user and an space." if user.blank? || space.blank?

    host = ENV["OLD_HOST"]
    port = ENV["OLD_PORT"]
    username = ENV["OLD_USERNAME"]
    password = ENV["OLD_PASSWORD"]
    database = ENV["OLD_DATABASE"]

    client = Mysql2::Client.new(host:, port:, username:, password:, database:)

    query = "select * from Post"
    results = client.query(query)

    results.each do |row|
      content = row["text"]
      Post.create!(
        title: row["title"],
        content:,
        copy_protect: row["copyProtect"],
        created_at: row["createdAt"].to_time.since(9.hours),
        updated_at: row["updatedAt"].to_time.since(9.hours),
        published: true,
        markdown: true,
        space:,
        user:
      )
    end
  end
end
