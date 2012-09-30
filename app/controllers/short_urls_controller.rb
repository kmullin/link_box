class ShortUrlsController < ApplicationController

  before_filter :authenticate_admin!

  def create
    render :nothing => true unless params[:asset]
    @asset = Asset.find(params[:asset])
    @short_url = @asset.short_urls.create
    link_id = @short_url.link_id
    url = url_for download_path(link_id)
    render :json => {:link_id => link_id, :url => url}.to_json
  end

  def destroy
    render :nothing => true unless params[:id]
    @short_url = ShortUrl.find_by_link_id(params[:id])
    url = url_for download_path(@short_url.link_id)
    @short_url.destroy if @short_url
    render :json => {:result => 'success', :url => url}.to_json
  end

end
