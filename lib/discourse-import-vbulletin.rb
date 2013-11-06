require 'rails'

module DiscourseImportVbulletin
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/vbulletin_import_tasks.rake'
    end
  end
end
