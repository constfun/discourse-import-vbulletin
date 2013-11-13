require 'rails'

module Vb
  # This allows us to use a different connection for vb models.
  # See "Connection to multiple databases in different models" at
  # http://api.rubyonrails.org/classes/ActiveRecord/Base.html
  class Base < ActiveRecord::Base
    self.abstract_class = true

    # We can also override table_name and primary_key methods if this doesn't work for all tables.
    self.pluralize_table_names = false
    self.primary_key_prefix_type = :table_name

    def readonly?
      true
    end
  end

  # vBulletin stores a bund of things as a list of ids.
  # This lets use use the 'serialize' to load objects referenced by such fields.
  class CsvCoder
    def initialize(model)
      @model = model
    end

    def load(csv)
      @model.find csv.split(',')
    end

    def dump; end
  end


  # Models

  class User < Base
    serialize :membergroupids, CsvCoder.new(Usergroup)
  end

  class Usergroup < Base
  end

  class Forum < Base; end
end
