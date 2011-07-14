require 'format'

class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :assignments
  has_many :roles, :through => :assignments
  has_many :orders
  has_many :order_items, :through => :orders
  has_one :cart

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_format_of     :email, :with => Format::EMAIL, :message => "is not valid"

  def role_symbols
    roles.map do |role|
      role.title.underscore.to_sym
    end
  end
  
  def authorized?(role)
    role_symbols.include?(role.to_sym)
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def send_forgot_password!
    reset_perishable_token!
    UserMailer.deliver_password_reset_instructions(self)
  end
end