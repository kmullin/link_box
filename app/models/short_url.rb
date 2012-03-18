class ShortUrl < ActiveRecord::Base
  belongs_to :asset, :autosave => true

  before_validation :generate_random_link, :on => :create
  validates :link_id, :uniqueness => true
#  validates :asset_id, :presence => true

  def self.full_url(url)
    '/dl/' + url
  end

  private

  def generate_random_link
    alphanumerics = ('a'..'z').to_a.concat(('A'..'Z').to_a.concat(('0'..'9').to_a))
    self.link_id = alphanumerics.sort_by{rand}.join[0..5]
    generate_random_link unless ShortUrl.find_by_link_id(self.link_id).nil?
  end

end
