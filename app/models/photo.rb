class Photo < ActiveRecord::Base
  belongs_to :photo_album

  has_attached_file :picture,
    default_url: '/images/:style/missing.png',
    styles: { medium: '768x432#', large: '1920x1080#' },
    convert_options: {
      medium: "-quality 75 -strip -interlace plane",
      large: "-quality 80 -interlace plane",
    }



  validates_attachment_content_type :picture, content_type: 'image/jpeg'
  validates_attachment_file_name :picture, matches: [/jpe?g\Z/]
  validates_attachment_size :picture, less_than: 5.megabytes

end
