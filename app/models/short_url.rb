class ShortUrl < ActiveRecord::Base
  belongs_to :asset

  before_create :generate_random_link

  before_validation :check_unique_link

  def generate_random_link
    alphanumerics = ('a'..'z').to_a.concat(('A'..'Z').to_a.concat(('0'..'9').to_a))
    #self.link_id = 'ad3Dfs'
    self.link_id = alphanumerics.sort_by{rand}.join[0..5]

    generate_random_link unless ShortUrl.where(:link_id => self.link_id).count == 0
  end

  # Fix this check to check for uniqness
  def check_unique_link
    self.link_id = ShortUrl
  end

  def self.full_url(url)
    '/dl/' + url
  end

end
