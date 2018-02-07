class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    # if user.user_role == 1
    #   can :manage, :all
    # else
      can :read, :all
    # end

    alias_action :create, :update, :destroy, :to => :crud

    # can :crud, Board, user_id: user.id
    can :crud, Board do |board|
      user == board.user
    end

    can :crud, List do |list|
      user == list.board.user
    end

    # can :crud, Card do |card|
    #   can?(:crud, card.list)
    #   # user == card.list.board.user
    # end

    can :crud, User do |user1|
      user == user1
    end

  end
end
