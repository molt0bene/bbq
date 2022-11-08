class UserContext
  attr_accessor :user, :cookies

  def initialize(user, cookies)
    @user = user
    @cookies = cookies
  end
end
