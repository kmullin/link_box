class AssetsController < ApplicationController

  def index
    @hash = {}
    Asset.all(:include => :short_urls).each { |a| @hash[a.filename] = a.short_urls.map { |u| u.link_id }}
  end

  def download
    @asset = ShortUrl.find_by_link_id!(params[:link_id]).asset
    @link_id = params[:link_id]
    head(
      :x_accel_redirect => '/files/' + @asset.filename,
      :content_type => @asset.content_type || 'application/stream',
      :content_disposition => "attachment; filename=\"#{@asset.filename}\""
    ) if request.referrer == "http://localhost:3000#{ShortUrl.full_url(params[:link_id])}"
  end

end
