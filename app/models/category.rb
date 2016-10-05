class Category < ActiveRecord::Base
  has_many :activity
  has_many :news
end
