class Asset < ActiveRecord::Base
  has_many :short_urls, :dependent => :destroy

  def file_extension
    File.extname(file_name).downcase rescue nil
  end

end
