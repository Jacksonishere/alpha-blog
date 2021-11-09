class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username, presence: true, 
                        uniqueness: { case_sensitive: false}, 
                        length: {minimum: 3, maximum: 25}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false},
                    length: { maximum: 105},
                    format: { with: VALID_EMAIL_REGEX  }

  
  # def email=(raw_email)
  #   super(raw_email.downcase)
  #   # no work
  #   # self.email = raw_email.downcase
  # end

  has_many :articles, dependent: :destroy
  has_secure_password
end
