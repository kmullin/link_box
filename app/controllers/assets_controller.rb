class AssetsController < ApplicationController

  def new
    @asset = Asset.new
  end

  def index
    @assets = Asset.all.map { |n| [n.file_name, n.file_extension].join(' => ') }
    @links = ShortUrl.all
  end

end
