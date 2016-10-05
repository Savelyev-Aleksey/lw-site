module Trimmed
  extend ActiveSupport::Concern


  included do
    before_validation :strip_input_fields
  end

  protected

  def strip_input_fields
    self.attributes.each do |key, value|
      self[key] = value.strip if value.respond_to?("strip")
    end
  end

  module ClassMethods
  end


end
