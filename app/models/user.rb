# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'digest'
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_accessor :password

  validates :name, :presence => true,
                   :length   => { :maximum => 50 }

  validates :email, :presence => true,
                    :format   => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    :uniqueness => { :case_sensitive => false }

  validates :password, :presence => true,
                       :length   => { :within => 6 .. 40 },
                       :confirmation => true

  before_save :encrypt_password

  def match_password?(str)
    encrypt(str) == encrypted_password
  end
    
  def self.authenticate(email, pass)
    u = find_by_email(email) 
    return nil if u.nil?
    return u if u.match_password?(pass)
  end

  def self.authenticate_with_salt(id, salt)
    u = find_by_id(id)
    return nil if u.nil?
    return u if u.salt == salt
  end 

  private
    def encrypt_password
      self.salt = make_salt if new_record? 
      self.encrypted_password = encrypt(password)
    end

    def make_salt
      secure_hash("#{Time.now.utc} -- #{password}")
    end

    def encrypt(src)
      secure_hash("#{salt} -- #{src}")  
    end

    def secure_hash(src)
      Digest::SHA2.hexdigest src
    end
end
