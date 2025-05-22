class UserSerializer
  def initialize(user)
    @user = user
  end

  def as_json
    {
      id: @user.id,
      email: @user.email,
      created_at: @user.created_at
      # Only expose what you want
    }
  end

  def to_json(*args)
    as_json.to_json(*args)
  end
end
