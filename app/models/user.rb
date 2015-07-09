class User < ActiveRecord::Base
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	USER_REGEX = /\A[a-z0-9_-]{1,20}\z/i
	PASSWORD_REGEX = /\A[a-z0-9_-]{1,20}\z/i
	NAME_REGEX = /\A[a-z-]{1,30}\z/i

 
  validates :password, presence: true, length: { minimum: 8 }
  # validates :password, format: { with: PASSWORD_REGEX, 
  #                                 message: "is not a valid password. Only chars, nums, hyphen, underscore, 1-20 chars"}
  validates :email, uniqueness: true, presence: true
  validates :email, format: { with: EMAIL_REGEX,
                              message: "is not a valid email." }
  validates :user_name, uniqueness: true, presence: true
  validates :user_name, format: { with: USER_REGEX, 
                                  message: "is not a valid username. Only chars, nums, hyphen, underscore, 1-20 chars"}
  validates :first_name, presence: true
  validates :first_name, format: { with: NAME_REGEX, 
                                  message: "is not a valid name. Only chars, hyphen, 1-30 chars"}
  validates :last_name, presence: true
  validates :last_name, format: { with: NAME_REGEX, 
                                  message: "is not a valid name. Only chars, hyphen, 1-30 chars"}

  has_many :flights
  has_many :user_flights, through: :flights
  

  before_validation :ensure_access_token

  def ensure_access_token
    if self.access_token.blank?
      self.access_token = User.generate_token
    end
  end

  def self.generate_token
    token = SecureRandom.hex
    while User.exists?(access_token: token)
      token = SecureRandom.hex
    end
    token
  end

end