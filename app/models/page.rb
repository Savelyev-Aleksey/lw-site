class Page < ActiveRecord::Base
  include Trimmed

  validates :symlink, :title, presence: true
  validates :symlink, format: {with: /\A[a-z]+\z/}

end
