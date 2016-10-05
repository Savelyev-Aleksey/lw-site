class PhotoAlbum < ActiveRecord::Base
  include Trimmed

  has_many :photos, dependent: :destroy

  validates :title, presence: true

  paginates_per 12

end
