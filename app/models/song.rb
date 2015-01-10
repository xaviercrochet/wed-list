class Song < ActiveRecord::Base
  belongs_to :user

  after_create :generate_youtube_url_if_nil_url

  def generate_youtube_url_if_nil_url
    if self.url.empty?
      self.url = "http://www.youtube.com/results?search_query="+self.artist+"+"+self.title
      self.save
    end
  end
end
