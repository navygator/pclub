class Message < ActiveRecord::Base
  belongs_to :user
  
  def user_name
    user.name
  end
  
  def creation_time
    created_at.strftime("%H:%M")
  end
end
