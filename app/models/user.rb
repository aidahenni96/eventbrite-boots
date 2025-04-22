class User < ApplicationRecord
  after_create :create_stripe_customer
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :attendances
  has_many :events, through: :attendances
  has_many :administered_events, class_name: 'Event', foreign_key: 'admin_id'

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  after_create :send_welcome_email

end


def send_welcome_email
  UserMailer.welcome_email(self).deliver_later
end

def create_stripe_customer
  customer = Stripe::Customer.create({
    email: self.email,
  })
  self.stripe_customer_id = customer.id
  self.save
end