class Asset < ActiveRecord::Base
  has_many :short_urls, :dependent => :destroy

  validates_uniqueness_of :filename, :scope => :web_dir

  before_save :file_metadata
  after_create :create_link

  attr_accessible :description, :notes

  def basename
    File.basename(self.filename)
  end

  def filename
    prefix = self.web_dir.nil? ? nil : APP_CONFIG["#{self.web_dir}_dir".to_sym]
    File.expand_path(File.join([prefix, read_attribute(:filename)].compact))
  end

  private

  def file_metadata
    self.original_filename ||= self.basename
    self.content_type ||= `file -b --mime-type "#{self.filename}"`.chomp
    self.size ||= File.size(self.filename)
  end

  def create_link
    self.short_urls.create
  end

end
