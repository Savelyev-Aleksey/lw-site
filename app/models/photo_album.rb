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

    # try find some year in query
    pos_year = query.index /\d{4}/
    # find in title by query if date not exist or number not a date
    if pos_year.nil? || query[pos_year, 4].to_i < 1900
      return where('title iLIKE ?', '%' + query + '%').order(title: :asc).
             first(limit)
    end

    # Year was found exclude year from query
    year = query[pos_year, 4].to_i
    # exclude year from query
    search = query[0...pos_year] + query[pos_year + 4..-1]
    search.strip!

    # try to find with some year
    res = where('`start_date` between ? AND ? AND `title` iLIKE ?',
                year.to_s + '-01-01', + year.to_s + '-12-31', '%' + search + '%').
          order(title: :asc).first(limit)

    # find with year set in title
    unless res.count
      res = where('title iLIKE ?', '%' + query + '%').order(title: :asc).first(limit)
    end
    res
  end

end
