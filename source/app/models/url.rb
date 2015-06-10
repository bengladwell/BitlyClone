require 'uri'

class Url < ActiveRecord::Base
  before_save :shorten_address
  validates :address, :format => URI::regexp(%w(http https))
  validates_uniqueness_of :unique_key

  def validate_url
    if self.address.match(/^https?:\/\//).nil?
      return false
    else
      validates self.address, :format => URI::regexp(%w(http https))
    end
  end

  def shorten_address
    if self.unique_key.nil?
      self.unique_key = 8.times.map { [*'0'..'9', *'a'..'z'].sample }.join
    end
  end

end
