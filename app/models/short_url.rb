class ShortUrl < ActiveRecord::Base
  belongs_to :asset

  def generate_random_link
    alphanumerics = ('a'..'z').to_a.concat(('A'..'Z').to_a.concat(('0'..'9').to_a))
    self.link_id = alphanumerics.sort_by{rand}.to_s[0..5]

    generate_random_link unless ShortUrl.where(:link_id => @key).count == 0
  end
end
