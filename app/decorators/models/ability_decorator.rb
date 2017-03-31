Erp::Ability.class_eval do
  def online_store_ability(user)
    can :delete, Erp::Products::Comment do |comment|
      user.backend_access
    end
    can :delete, Erp::Articles::Comment do |comment|
      user.backend_access
    end
    can :delete, Erp::Products::Rating do  |rating|      
      user.backend_access or rating.user_id == user.id
    end
  end
end