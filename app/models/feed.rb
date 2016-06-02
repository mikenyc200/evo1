require 'digest/md5'
require './././alchemyapi_ruby/alchemyapi'
# require 'htmlentities'


class Feed < ActiveRecord::Base
    has_many :entries, dependent: :destroy
    validates :url, uniqueness: true

  def secret
    Digest::MD5.hexdigest(created_at.to_s)
  end

  def notified params
    update_attributes(:status => params["status"]["http"])
    params['items'].each do |i|
      Thread.new {
      url_temp =  i["permalinkUrl"]
      next if Entry.all.pluck(:url).include? url_temp or url_temp.include? "redirect"
      @image_temp = extract_image(i)

      entries.create(:atom_id => i["id"], :title => i["title"], :url => i["permalinkUrl"], :content => i["content"], :image => @image_temp)
    }
    end
  end

  def extract_image(resp)

    begin
      resp["standardLinks"].each do |l, v|
        h = v[0]
        next if h["type"].blank? or !h["type"].include? "image"
            return h["href"]
      end

    rescue => e
      logger.error e.message
      return nil
    end

    return nil
  end

end
