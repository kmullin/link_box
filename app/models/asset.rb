class Asset < ActiveRecord::Base
  has_many :short_urls, :dependent => :destroy

  def file_extension
    File.extname(filename).downcase rescue nil
  end

end
