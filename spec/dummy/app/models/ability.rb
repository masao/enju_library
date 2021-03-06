class Ability
  include CanCan::Ability

  def initialize(user, ip_address = nil)
    case user.try(:role).try(:name)
    when 'Administrator'
      can [:read, :create, :update], Bookstore
      can :manage, BudgetType
      can :destroy, Bookstore do |bookstore|
        if defined?(EnjuPurchaseRequest)
          bookstore.order_lists.empty? and bookstore.items.empty?
        else
          bookstore.items.empty?
        end
      end
      can [:read, :create, :update], Library
      can :destroy, Library do |library|
        library.shelves.empty? and !library.web?
      end
      can [:read, :update], LibraryGroup
      can [:read, :update], RequestStatusType
      can [:read, :update], RequestType
      can [:read, :create, :update], Shelf
      can :destroy, Shelf do |shelf|
        shelf.items.empty?
      end
      can :manage, SearchEngine
      can :manage, Subscribe
      can :manage, Subscription
    when 'Librarian'
      can :read, Bookstore
      can :read, BudgetType
      can :read, Library
      can :read, LibraryGroup
      can :read, RequestStatusType
      can :read, RequestType
      can :read, Shelf
      can :read, SearchEngine
      can :manage, Subscribe
      can :manage, Subscription
    when 'User'
      can :read, Shelf
      can :read, Library
      can :read, LibraryGroup
    else
      can :read, Library
      can :read, LibraryGroup
      can :read, Shelf
    end
  end
end
