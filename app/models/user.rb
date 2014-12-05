class User < ActiveRecord::Base
  has_many :goals
  has_many :schedules, through: :goals
  has_many :statuses

   include BCrypt

   def password
    @password ||= Password.new(hashed_password)
   end

   def password=(new_password)
    @password = Password.create(new_password)
    self.hashed_password = @password
   end

  def authenticate(user_password)
    return true if Password.new(self.hashed_password) == user_password
    false
  end
end

