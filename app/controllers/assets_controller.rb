class AssetsController < ApplicationController

  def download
    @link_id = params[:link_id]
    @asset = ShortUrl.find_by_link_id!(@link_id).asset
    if request.referrer == (url_for download_path @link_id, :only_path => false)
      send_file(
        @asset.filename,
        :filename => @asset.original_filename,
        :type => @asset.content_type
      )
    end
  end

end
