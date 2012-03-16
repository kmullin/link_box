class Asset < ActiveRecord::Base

  def file_extension
    File.extname(file_name).downcase rescue nil
  end

  def generate
  end

end
