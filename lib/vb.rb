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
  end

  class User < Base; end
end
