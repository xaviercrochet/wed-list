class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save { self.email = email.downcase }
  has_many :transactions, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_one :participation, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :phone, presence: true
  scope :coming, -> {where(coming: true)}

  def update_rsvp!
    current_status = self.coming
    self.coming = ! current_status
    self.save
  end

  def not_responded_yet?
    self.participation.nil?
  end

  def not_coming?
    ! self.participation.nil? && self.participation.adults == 0 && self.participation.kids == 0
  end

  def coming?
    ! self.not_responded_yet? && ! self.not_coming?
  end
end
