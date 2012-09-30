class UploadController < ApplicationController

  before_filter :authenticate_admin!

  def index
  end

  # take file upload and create new asset and save to upload folder
  def create
    uploaded_file = params[:file_upload][:my_file]
    uuid = Digest::SHA2.hexdigest("#{Time.now.utc}_#{srand}_#{uploaded_file.original_filename}").first(8)
    first_dir = uuid[0..1]
    second_dir = uuid[2..3]
    file_prefix = uuid[4..-1]
    upload_filename = if APP_CONFIG[:mask_uploads]
      Digest::SHA2.hexdigest(uploaded_file.original_filename).first(32)
    else
      uploaded_file.original_filename.gsub(/\s+/, '_')
    end
    upload_path = File.join(first_dir, second_dir, "#{file_prefix}_#{upload_filename}")
    new_asset = Asset.new()
    new_asset.filename = upload_path
    new_asset.web_dir = 'upload'
    new_asset.original_filename = if APP_CONFIG[:mask_uploads]
      upload_filename
    else
      uploaded_file.original_filename
    end
    if new_asset.valid?
      FileUtils.mkdir_p(File.dirname(new_asset.filename))
      FileUtils.cp(uploaded_file.tempfile, new_asset.filename)
      FileUtils.chmod(0644, new_asset.filename)
      new_asset.save
    else
      # gotta return false if not valid
    end
    redirect_to :controller => :admin
  end

end
