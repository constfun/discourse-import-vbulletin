require 'vb'
require 'rails'

namespace :vbulletin do
  task :vb_environment => ['db:load_config'] do
    config = ActiveRecord::Base.configurations['vbulletin']
    Vb::Base.establish_connection config
  end

  desc 'Do the import.'
  task :import => [:vb_environment, :environment] do
    puts "First discourse user: #{User.first.name}"
    puts "First vbulletin user: #{Vb::User.first.username}"
  end
end
