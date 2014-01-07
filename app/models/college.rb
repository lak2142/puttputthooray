class College < ActiveRecord::Base
  resourcify
  acts_as_mappable :default_units => :miles,
                   :distance_field_name => :distance,
                   :default_formula => :sphere,
                   :lat_column_name => :lat,
                   :lng_column_name => :lon

end

