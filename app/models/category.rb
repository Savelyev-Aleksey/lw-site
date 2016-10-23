class Category < ActiveRecord::Base
  include Trimmed

  has_many :activity

  validates :title, :color, presence: true
  
end
