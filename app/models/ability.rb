class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    return if user.nil?
    @user = user
    send user.role
  end

  private

  def sudo
    can :manage, Request
    can :manage, User
    can :manage, ActivityMonitor

    hr_executive
  end

  def hr_executive
    can :manage, Request if @request.status == 'open'
    can :manage, User
    can [:create, :update], ActivityMonitor

  end

  def general
    can [:new, :edit, :create, :update], User,
    can [:new, :edit, :create], Request
    can [:update], Request, status: 1..2
    can [:create, :update], ActivityMonitor
  end
end
