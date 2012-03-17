class AssetsController < ApplicationController

  def index
    @hash = {}
    Asset.all.each { |a| @hash[a.filename] = a.short_urls.map { |u| u.link_id }}
  end

end
