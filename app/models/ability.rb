class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, ActiveAdmin::Page, :name => "Dashboard"
    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'delivery_boy'
      can :manage, Cart
    elsif user.role == 'vendor'
      can :manage, Product
      can :manage, ProductCart  
    end
    
  end
end
