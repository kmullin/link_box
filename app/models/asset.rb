class Asset < ActiveRecord::Base
  has_many :short_urls, :dependent => :destroy

  validates_associated :short_urls, :presence => true

  after_save :create_link

  def file_extension
    File.extname(filename).downcase rescue nil
  end

  private

  def create_link
    self.short_urls.create
  end

end
