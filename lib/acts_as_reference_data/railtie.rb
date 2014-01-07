module ActsAsReferenceData
  class ReferenceDataRailtie < Rails::Railtie
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.send :extend, ActsAsReferenceData
    end
  end
end
