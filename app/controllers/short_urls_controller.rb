class ShortUrlsController < ApplicationController

  def download
    @asset = ShortUrl.find_by_link_id!(params[:link_id]).asset
    head(
      :x_accel_redirect => '/files/' + @asset.filename,
      :content_type => 'application/stream',
      :content_disposition => "attachment; filename=\"#{@asset.filename}\""
    )
  end

end
