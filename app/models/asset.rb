class Asset < ActiveRecord::Base
  has_many :short_urls
end
