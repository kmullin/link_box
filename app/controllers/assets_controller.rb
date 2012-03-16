class AssetsController < ApplicationController

  def new
    @asset = Asset.new
  end

  def index
    @assets = Asset.all.map { |n| [n.file_name, n.description].join(' => ') }
    @links = ShortUrl.all
  end

end
