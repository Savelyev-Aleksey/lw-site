class Activity < ActiveRecord::Base
  include Trimmed

  validates :title, :text, :date, presence: true

  belongs_to :category
  belongs_to :photo_album

  paginates_per 10

end
