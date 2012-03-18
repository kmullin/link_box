class AssetsController < ApplicationController

  def index
    @hash = {}
    Asset.all.each { |a| @hash[a.filename] = a.short_urls.map { |u| u.link_id }}
  end

  def download
    @asset = ShortUrl.find_by_link_id!(params[:link_id]).asset
    head(
      :x_accel_redirect => @asset.path + '/' + @asset.filename,
      :content_type => 'application/stream',
      :content_disposition => "attachment; filename=\"#{@asset.filename}\""
    )
  end

end
