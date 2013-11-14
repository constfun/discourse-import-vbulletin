module VbModels
  # vBulletin stores a bunch of things as a comma separated list of ids in a text field.
  # This lets us use ActiveRecord::Base.serialize to load objects referenced by such fields.
  class CsvCoder
    def self.load(csv)
      csv.split(',')
    end

    def self.dump;
      raise ReadOnlyRecord
    end
  end

  module Associations
    def constantize(class_name)
      "VbModels::#{class_name}".constantize
    end

    def belongs_to_many_comma_separated(name, options)
      # This generates a method that returns an array of ids (eg. membergroupids).
      serialize name, CsvCoder

      # This generates a method that returns the actual objects (eg. membergroups).
      associated_objects_accessor_name = name.to_s.chomp('ids').pluralize
      define_method associated_objects_accessor_name do
        # https://github.com/rails/rails/blob/f8e5022c73679f41db9bb6743179bab4571fb28e/activesupport/lib/active_support/core_ext/string/inflections.rb#L65
        # http://ruby-doc.org/core-2.0.0/Object.html#method-i-send
        self.class.constantize(options[:class_name]).find self.send(name)
      end
    end

    def has_many_comma_separated(name, options)
      define_method name.to_s do
        model_class = self.class.constantize(options[:class_name])
        model_class.find_by_sql "select * from #{model_class.table_name} where FIND_IN_SET(#{self.id}, #{options[:field_name]})"
      end
    end
  end

  # This allows us to use a different connection for vb models.
  # See "Connection to multiple databases in different models" at
  # http://api.rubyonrails.org/classes/ActiveRecord/Base.html
  class Base < ActiveRecord::Base
    extend Associations

    self.abstract_class = true

    # Lets err on the safe side and preovent saving of vb models.
    def readonly?
      true
    end

    # We can also override table_name and primary_key methods if this doesn't work for all tables.
    self.pluralize_table_names = false
    self.primary_key_prefix_type = :table_name

    # Override the way foreign key names are built for associations.

    def self.has_many(name, options = {}, &extension)
      options[:foreign_key] ||= self.table_name + 'id'
      super
    end

    def self.has_one(name, options = {})
      options[:foreign_key] ||= self.table_name + 'id'
      super
    end

    def self.belongs_to(name, options = {})
      options[:foreign_key] ||= name.to_s + 'id'
      super
    end
  end
end
