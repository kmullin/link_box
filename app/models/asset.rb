class Asset < ActiveRecord::Base
  has_many :short_urls, :dependent => :destroy

  after_create :create_link

  def file_extension
    File.extname(filename).downcase rescue nil
  end

  private

  def create_link
    self.short_urls.create
  end

end
