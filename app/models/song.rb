class Song < ActiveRecord::Base
  belongs_to :user
  validates :url, :format => URI::regexp(%w(http https)), :if => :not_empty?
  validates_presence_of :title, :artist
  after_create :generate_youtube_url_if_nil_url

  def generate_youtube_url_if_nil_url
    if self.url.empty?
      self.url = "http://www.youtube.com/results?search_query="+self.artist+"+"+self.title
      self.save
    end
  end

  def not_empty?
    ! self.url.empty?
  end



end
