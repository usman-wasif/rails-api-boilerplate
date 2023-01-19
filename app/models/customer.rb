class Customer < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :cms_customer_id, presence: true
  validates :email, format: { with: Devise.email_regexp }, presence: true, length: { minimum: 3 }
  validates :phone, :presence => true,
                    :length => { :minimum => 10, :maximum => 15 }
end


