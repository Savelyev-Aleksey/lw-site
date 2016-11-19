class PhotoAlbum < ActiveRecord::Base
  include Trimmed

  has_many :photos, dependent: :destroy
  has_many :activities

  validates :title, presence: true

  paginates_per 12

  def title_with_year
    title + ' - ' + start_date.year.to_s
  end

  def self.search_with_date(query, limit = 0)
    query.strip!
    return [] if query.length < 3

    # find some year
    pos_year = query.index /\d{4}/
    # check some real year in query
    if pos_year.nil? or query[pos_year,4].to_i < 1900
      return self.where('title iLIKE ?', '%'+query+'%').order(title: :asc).
      first(limit)
    end
    year = query[pos_year,4].to_i
    # exclude year from query
    search = query[0...pos_year] + query[pos_year+4..-1]
    search.strip!
    # try to find with some year
    res = self.where('("photo_albums"."start_date" between ? AND ?)
      AND "photo_albums"."title" iLIKE ?',
      year.to_s+'-01-01', +year.to_s+'-12-31', '%'+search+'%').
      order(title: :asc).first(limit)
    # find with year set in title
    unless res.count
      res = self.where('title iLIKE ?', '%'+query+'%').order(title: :asc).
      first(limit)
    end
    res
  end

end
