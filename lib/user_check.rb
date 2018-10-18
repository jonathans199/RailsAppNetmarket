module UserCheck

  # check if user has two directs
  def self.user_has_two_directs_each_side?(user)
    children = user.children
    two_directs_on_tree = false if children.count < 2
    two_directs_on_tree = true if children.map { |x| x.left_son }.include?(true) && children.map { |x| x.left_son }.include?(false)

    left_direct_childs  = []
    right_direct_childs = []

    if two_directs_on_tree
      query = user.children.where(sponsor_uuid:user.uuid).select(:id,:left_son)
      query.map { |x| left_direct_childs <<   x if x.left_son  }
      query.map { |x| right_direct_childs <<  x if !x.left_son  }
      # s
      left_descendants  = user.children.where(left_son:true).last.descendants.select(:id,:sponsor_uuid).map { |x|  left_direct_childs << x if x.sponsor_uuid == user.uuid  }.compact
      right_descendants = user.children.where(left_son:false).last.descendants.select(:id,:sponsor_uuid).map { |x| right_direct_childs << x   if x.sponsor_uuid == user.uuid  }.compact
    end
    return true if left_direct_childs.count > 0 && right_direct_childs.count > 0
    false
  end
  
  def self.user_has_two_directs?(user)
    childs = User.where(sponsor_uuid:user.uuid).select(:id).count
    return true if childs > 1
    false
  end
  # Check if user rewards are lower than 25000 before asign a new one
  def self.max_payment_week(user)
    result = user
      .rewards
      .where(created_at: (Time.now.beginning_of_week)..Time.now)
      .select(:value)
      .map { |x| x.value }
      .reduce(0,:+)
    return true if result >= 100000
    false
  end

  # check last expire plan for user
  def self.user_expired?(user)
    subs  = user.subscriptions.select(:id,:subscription_status_id,:expiration)
    codes = subs.map { |x| x.subscription_status_id }
    return false if codes.include?(11)
    return self.check_expiration_date(subs) if codes.include?(12) && !codes.include?(11)
  end

  # check distance of expiration and actual date for given subscriptions
  def self.check_expiration_date(array)
    result = array.map { |x| (((Time.now - x.expiration).to_i) / 3600) / 24 }
    result = result.map { |y| return true if y > 15 }
    return true if result.include?(true)
    false
  end
end