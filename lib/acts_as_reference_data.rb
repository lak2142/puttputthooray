require 'acts_as_reference_data/railtie' if defined?(Rails)

module ReferenceData
  def method_missing(meth, *args, &block)
    @@refs ||= {}
    @@refs[self.name.downcase]||= load_ref_data
    val = @@refs[self.name.downcase].select {|s| s.code == meth.to_s}
    if val.present?
      val.first
    else
      super
    end
  end

  def load_ref_data
    self.all
  end
end

module ActsAsReferenceData
  def acts_as_reference_data
    extend ReferenceData
  end
end
