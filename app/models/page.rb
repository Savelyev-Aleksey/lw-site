class Page < ActiveRecord::Base
  include Trimmed

  validates :symlink, :title, presence: true
  validates :symlink, format: {with: /\A[a-z\-_]+\z/},
            uniqueness: { case_sensitive: false }

  scope :basic, -> {where("tech IS NULL")}

end
