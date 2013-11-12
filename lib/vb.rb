require 'rails'

module Vb
  # This allows us to use a different connection for vb models.
  # See "Connection to multiple databases in different models" at
  # http://api.rubyonrails.org/classes/ActiveRecord/Base.html
  class Base < ActiveRecord::Base
    self.abstract_class = true
  end

  class User < Base
    self.table_name = 'user'
    self.primary_key = 'userid'
  end
end
