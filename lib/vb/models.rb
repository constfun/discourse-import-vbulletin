require 'vb/models_base'

module VbModels
  class User < Base
    belongs_to :usergroup
    belongs_to_many_comma_separated :membergroupids, class_name: 'Usergroup'
    has_one :customavatar
  end

  class Usergroup < Base
    has_many :users
    has_many_comma_separated :additional_users, class_name: 'User', field_name: :membergroupids
  end

  class Customavatar < Base
    belongs_to :user
  end
end
