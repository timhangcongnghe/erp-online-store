Erp::Ability.class_eval do
  def online_store_ability(user)
    can :create, Erp::Products::Comment do |comment|
      !user.nil? && user.get_permissions["products_comments"]["create"] == "yes"
    end
    can :delete, Erp::Products::Comment do |comment|
      !user.nil? && user.get_permissions["products_comments"]["delete"] == "yes" # user.backend_access &&
    end


    can :create, Erp::Products::Rating do |rating|
      !user.nil? && user.get_permissions["products_ratings"]["create"] == "yes"
    end
    can :delete, Erp::Products::Rating do  |rating|
      !user.nil? && (rating.user_id == user.id or user.get_permissions["products_ratings"]["delete"] == "yes")
    end

    can :create, Erp::Articles::Comment do |comment|
      !user.nil? && user.get_permissions["articles_comments"]["create"] == "yes"
    end
    can :delete, Erp::Articles::Comment do |comment|
      !user.nil? && user.get_permissions["articles_comments"]["delete"] == "yes" # && user.backend_access
    end
  end
end
