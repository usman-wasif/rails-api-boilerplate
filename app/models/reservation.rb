class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :vehicle
  accepts_nested_attributes_for :customer, :reject_if => :check_customer

  validates :date, presence: true
  validates :time, presence: true
  validate :date_greater_than_today

  protected

  def check_customer(customer_attr)
    return false unless new_record?
    if _customer = Customer.find_by(email: customer_attr[:email])
      self.customer = _customer
      return true
    end
  end

  def date_greater_than_today
    if self.date && self.date < DateTime.now
      errors.add(:date, I18n.t('errors.invalid_date'))
    end
  end
end
