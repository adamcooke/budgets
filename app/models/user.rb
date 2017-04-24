# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email_address   :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email_address, :presence => true, :format => {:with => /\A\b[A-Z0-9\.\_\%\-\+]+@(?:[A-Z0-9\-]+\.)+[A-Z]{2,}\b\z/i, :allow_blank => true}, :uniqueness => true

  has_many :budgets, :dependent => :destroy

  has_secure_password

  def self.authenticate(email, password)
    user = self.find_by_email_address(email)
    return nil unless user
    return nil unless user.authenticate(password)
    return user
  end

end
