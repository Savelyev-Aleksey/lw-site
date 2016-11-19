class Activity < ActiveRecord::Base
  include Trimmed

  validates :title, :text, :date, presence: true

  belongs_to :category
  has_one :photo_ablum

  paginates_per 10

end
