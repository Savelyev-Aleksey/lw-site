class Activity < ActiveRecord::Base
  include Trimmed

  validates :title, :text, :date, presence: true

  belongs_to :category

  paginates_per 10

end
