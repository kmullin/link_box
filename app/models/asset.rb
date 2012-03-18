class Asset < ActiveRecord::Base
  has_many :short_urls, :dependent => :destroy

  validates :filename, :uniqueness => {:scope => :path}
  after_create :create_link

  attr_accessible :filename, :description, :notes

  def file_extension
    File.extname(filename).downcase rescue nil
  end

  private

  def create_link
    self.short_urls.create
  end

end
