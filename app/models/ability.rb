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
    can :manage, Request if
    can :manage, User
    cannot :destroy, User
    can [:create, :update], ActivityMonitor
    can :update, :current_company
    can :manage, :oauth2_client_apps

    general
  end

  def general
    can [:new, :edit, :create, :update], User
    can [:new, :edit, :create, :update], Request
  end
end
