class Ability
  include CanCan::Ability

  def initialize(user)

    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, Gift
      can :read, User, :user_id => user.id
      can :update, User, :user_id => user.id
      can :read, Transaction
      can :create, Transaction
      can :destroy, Transaction, :user_id => user.id, :order_id => nil
      can :create, Order
      can :read, Order, :user_id => user.id
      can :destroy, Order, :user_id => user.id, paid: false
      can :pay, Order, :user_id => user.id, paid: false
      can :paid, Order, user_id: user.id, paid: false
      can :read, Song
      can :create, Song
      can :destroy, Song, :user_id => user.id
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
