require 'vb'
require 'rails'

namespace :vbulletin do
  task :vb_environment => ['db:load_config'] do
    config = ActiveRecord::Base.configurations['vbulletin']
    Vb::Base.establish_connection config
  end

  desc 'Do the import.'
  task :import => [:vb_environment, :environment] do
    puts Vb::User.find(2022).membergroupids
  end
end
