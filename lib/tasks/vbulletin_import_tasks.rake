require 'vb'
require 'rails'

namespace :vbulletin do
  task :vb_environment => ['db:load_config'] do
    config = ActiveRecord::Base.configurations['vbulletin']
    VbModels::Base.establish_connection config
  end

  desc 'Do the import.'
  task :import => [:vb_environment, :environment] do
    u = VbModels::User.find(2022)
    puts u.username
    puts u.membergroupids
    puts u.membergroups
    puts u.customavatar

    ug = VbModels::Usergroup.find(33)
    puts "#{ug.title}: #{ug.additional_users.count}"
  end
end
