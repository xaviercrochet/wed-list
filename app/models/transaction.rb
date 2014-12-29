class Transaction < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :gift, dependent: :destroy
end
