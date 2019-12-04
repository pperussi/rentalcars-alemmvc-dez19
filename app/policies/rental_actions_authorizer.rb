class RentalActionsAuthorizer
  attr_reader :rental, :user

  def initialize(rental, user)
    @rental = rental
    @user = user
  end

  def authorized?
    user.admin? || rental.subsidiary == user.subsidiary
  end
end