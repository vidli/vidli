class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :assignments
  has_many :roles, :through => :assignments

  def role_symbols
    roles.map do |role|
      role.title.underscore.to_sym
    end
  end
  
  def authorized?(role)
    role_symbols.include?(role.to_sym)
  end
end
