module Compensation
  def self.update_matrix(invoice)
    matrix = Matrix.where(reedemed: false, plan_id: invoice.plan.id).map{ |x| x if x.user.subscriptions.count > 0 }.compact
    matrix.map { |x|
      users_array = x.users.split(",")
      if !users_array.include?(invoice.user.id.to_s)
        if users_array.count == 14
          self.check_matrix_bonus(x,invoice)
        else
          user_matrix_no = x.user.matrices.where(plan_id: x.plan_id).select(:id).count
          available = true
          available = false if user_matrix_no == 2 && self.directs_on_plan(x) < 3
          available = false if user_matrix_no == 3 && self.directs_on_plan(x) < 6
          available = false if user_matrix_no == 4 && self.directs_on_plan(x) < 9
          # available = false if (2..6).cover? user_matrix_no && self.directs_on_plan(x) < 3

          total = "#{x.users.to_s},#{invoice.user.id}" if available
          final_update = x.update(users: "#{total}") if available
        end
      end
    }
  end

  # matrix reach 14 users
  def self.check_matrix_bonus(matrix,invoice)

    user_matrix_no   = matrix.user.matrices.where(plan_id: matrix.plan_id).select(:id).count
    required_directs = 2
    required_directs = 5 if user_matrix_no == 2
    required_directs = 8 if user_matrix_no == 3
    required_directs = 11 if user_matrix_no == 4

    if self.directs_on_plan(matrix) >= required_directs
      value = ((matrix.plan.price * 14) * 0.05).round(2)
      total = "#{matrix.users.to_s},#{invoice.user.id}"
      bonus = matrix.user.rewards.create(value: value, reward_type_id: 15, reward_status_id: 11, currency_id: 11, subscription_id: matrix.user.subscriptions.last.id)
      final = matrix.update(reedemed: true, users: total) if bonus
      matrix.user.matrices.create(users:matrix.user.id, plan_id: matrix.plan.id) if final
    end
  end

  # create first matrix for parent user. Returns false if user already have matrix
  def self.first_matrix_on_plan(invoice)
    parent      = User.where(uuid:invoice.user.parent_uuid).select(:id,:uuid).last
    parent_plan = parent.subscriptions.where(subscription_status_id:11, plan_id: invoice.plan.id).last
    total       = "#{parent.id},#{invoice.user.id}"
    Matrix.create(user_id: parent.id, users:total, plan_id: invoice.plan.id) if parent_plan
  end

  def self.directs_on_plan(matrix)
    directs_on_plan = []
    User.where(parent_uuid:matrix.user.uuid).map { |x|
      directs_on_plan.push(x.username) if x.subscriptions.where(plan_id:matrix.plan_id).last
    }
    return directs_on_plan
  end

  # create direct bonus on the system
  def self.create_unilevel_bonus(invoice,subs)
    if !invoice.plan.subscription
      value       = ((invoice.plan.price * 10) / 100).round(2)
      first_user  = User.find_by(uuid: invoice.user.parent_uuid)
      first       = Reward.create(value: value, reward_type_id: 12, reward_status_id: 11, currency_id: 11, user_id: first_user.id, subscription_id: subs[:id]) if first_user && !UserCheck.max_payment_week(first_user)
      if first
        value         = ((invoice.plan.price * 5) / 100).round(2)
        second_user   = User.find_by(uuid: first_user.parent_uuid)
        second        = Reward.create(value: value, reward_type_id: 12, reward_status_id: 11, currency_id: 11, user_id: second_user.id, subscription_id: subs[:id]) if second_user && !UserCheck.max_payment_week(second_user)
      end
    end
  end

  # switch user temporal to user
  def self.temporal_to_user(temp_user)
    sponsor_uuid = temp_user.parent_uuid
    sponsor_uuid = User.roots.first.uuid if sponsor_uuid.nil?

    user = User.new(
      name: temp_user.name,
      last_name: temp_user.last_name,
      username: temp_user.username,
      email: temp_user.email,
      password_digest: temp_user.password_digest,
      phone: temp_user.phone,
      document: temp_user.document,
      sponsor_uuid: sponsor_uuid,
      last_login: temp_user.last_login,
      uuid: temp_user.uuid,
      address: temp_user.address,
      city: temp_user.city,
      country: temp_user.country,
      confirmed_at: temp_user.confirmed_at,
      parent_uuid: temp_user.parent_uuid,
      right: temp_user.right,
      active: temp_user.active
    )
    user.save
    user
  end

  # create user subscription
  def self.create_subscription(invoice)
    subs = Subscription.create(
      user_id: invoice.user_id, 
      plan_id: invoice.plan_id, 
      invoice_id:invoice.id, 
      subscription_status_id: 11, 
      expiration: Time.now.utc + invoice.plan.expiration_days.days
    )
  end

  # update invoice created
  def self.update_invoice(invoice, txid, user)
    invoice.update(
      invoice_status_id: 12,
      txid: txid,
      user_id: user.id,
      temp_user_id: nil)
    EmailNotification.send_notification(invoice)
  end

  
end