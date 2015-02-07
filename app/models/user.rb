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

  def update_rsvp!
    current_status = self.coming
    self.coming = ! current_status
    self.save
  end

  def disabled?
    self.coming?
  end

  def coming?
    ! self.participation.nil?
  end
end
