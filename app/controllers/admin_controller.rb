class AdminController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @hash = {}
    Asset.all(:include => :short_urls).each { |a| @hash[a] = a.short_urls.map { |u| u.link_id } }
    @admins = Admin.all
  end

end
