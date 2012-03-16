class AssetsController < ApplicationController

  def new
    @asset = Asset.new
  end

  def index
    @asset
  end

end
