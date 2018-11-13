module Compensation
  
  def self.update_matrix(invoice)
    matrix = Matrix.where(reedemed: false, plan_id: invoice.plan.id).map{ |x| x if x.user.subscriptions.count > 0 }.compact
    matrix.map { |x|
      users_array = x.users.split(",")
      if users_array.count == 14
        self.check_matrix_bonus(x,invoice)
      else
        user_matrix_no = x.user.matrices.where(plan_id: x.plan_id).select(:id).count
        allow = true
        allow = false if user_matrix_no == 1  && self.directs_on_matrix_by_plan(x) == 2 #1
        allow = false if user_matrix_no == 2  && self.directs_on_matrix_by_plan(x) < 2 || user_matrix_no == 2  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 2  && self.directs_on_matrix_by_plan(x) == 5 && x.user.uuid == invoice.user.parent_uuid #2
        allow = false if user_matrix_no == 3  && self.directs_on_matrix_by_plan(x) < 5 || user_matrix_no == 3  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 3  && self.directs_on_matrix_by_plan(x) == 8 && x.user.uuid == invoice.user.parent_uuid  #3
        allow = false if user_matrix_no == 4  && self.directs_on_matrix_by_plan(x) < 8 || user_matrix_no == 4  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 4  && self.directs_on_matrix_by_plan(x) == 11 && x.user.uuid == invoice.user.parent_uuid #4
        allow = false if user_matrix_no == 5  && self.directs_on_matrix_by_plan(x) < 11 || user_matrix_no == 5  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 5  && self.directs_on_matrix_by_plan(x) == 14 && x.user.uuid == invoice.user.parent_uuid #5
        allow = false if user_matrix_no == 6  && self.directs_on_matrix_by_plan(x) < 14 || user_matrix_no == 6  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 6  && self.directs_on_matrix_by_plan(x) == 17 && x.user.uuid == invoice.user.parent_uuid #6
        # until here matrix must have 3 directs
        allow = false if user_matrix_no == 7  && self.directs_on_matrix_by_plan(x) < 17 || user_matrix_no == 7  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 7  && self.directs_on_matrix_by_plan(x) == 21 && x.user.uuid == invoice.user.parent_uuid #7
        allow = false if user_matrix_no == 8  && self.directs_on_matrix_by_plan(x) < 21 || user_matrix_no == 8  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 8  && self.directs_on_matrix_by_plan(x) == 25 && x.user.uuid == invoice.user.parent_uuid #8
        allow = false if user_matrix_no == 9  && self.directs_on_matrix_by_plan(x) < 25 || user_matrix_no == 9  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 9  && self.directs_on_matrix_by_plan(x) == 29 && x.user.uuid == invoice.user.parent_uuid #9
        allow = false if user_matrix_no == 10 && self.directs_on_matrix_by_plan(x) < 29 || user_matrix_no == 10  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 10  && self.directs_on_matrix_by_plan(x) == 33 && x.user.uuid == invoice.user.parent_uuid #10
        allow = false if user_matrix_no == 11 && self.directs_on_matrix_by_plan(x) < 33 || user_matrix_no == 11  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 11  && self.directs_on_matrix_by_plan(x) == 37 && x.user.uuid == invoice.user.parent_uuid #11
        # until here matrix must have 4 directs
        allow = false if user_matrix_no == 12 && self.directs_on_matrix_by_plan(x) < 38 || user_matrix_no == 12  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 12  && self.directs_on_matrix_by_plan(x) == 42 && x.user.uuid == invoice.user.parent_uuid #12
        allow = false if user_matrix_no == 13 && self.directs_on_matrix_by_plan(x) < 43 || user_matrix_no == 13  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 13  && self.directs_on_matrix_by_plan(x) == 47 && x.user.uuid == invoice.user.parent_uuid #13
        allow = false if user_matrix_no == 14 && self.directs_on_matrix_by_plan(x) < 48 || user_matrix_no == 14  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 14  && self.directs_on_matrix_by_plan(x) == 52 && x.user.uuid == invoice.user.parent_uuid #14
        allow = false if user_matrix_no == 15 && self.directs_on_matrix_by_plan(x) < 54 || user_matrix_no == 15  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 15  && self.directs_on_matrix_by_plan(x) == 57 && x.user.uuid == invoice.user.parent_uuid #15
        allow = false if user_matrix_no == 16 && self.directs_on_matrix_by_plan(x) < 59 || user_matrix_no == 16  && users_array.count == 1 && x.user.uuid != invoice.user.parent_uuid ||  user_matrix_no == 16  && self.directs_on_matrix_by_plan(x) == 62 && x.user.uuid == invoice.user.parent_uuid #16
        # until here matrix must have 5 directs
        total = "#{x.users.to_s},#{invoice.user.id}" if allow
        final_update = x.update(users: "#{total}")   if allow
      end
    }
  end

  # matrix reach 14 users
  def self.check_matrix_bonus(matrix,invoice)
    user_matrix_no   = matrix.user.matrices.where(plan_id: matrix.plan_id).select(:id).count
    required_directs = 2 #1
    required_directs = 5 if user_matrix_no == 2 #2
    required_directs = 8 if user_matrix_no == 3 #3
    required_directs = 11 if user_matrix_no == 4 #4
    required_directs = 14 if user_matrix_no == 5 #5
    required_directs = 17 if user_matrix_no == 6 #6
    # until here user matrix must have 3 directs
    required_directs = 21 if user_matrix_no == 7 #7
    required_directs = 25 if user_matrix_no == 8 #8
    required_directs = 29 if user_matrix_no == 9 #9
    required_directs = 33 if user_matrix_no == 10 #10
    required_directs = 37 if user_matrix_no == 11 #11
    # until here user matrix must have 4 directs
    required_directs = 42 if user_matrix_no == 12 #12
    required_directs = 47 if user_matrix_no == 13 #13
    required_directs = 52 if user_matrix_no == 14 #14
    required_directs = 57 if user_matrix_no == 15 #15
    required_directs = 62 if user_matrix_no == 16 #16
    # until here every matrix must have 5 directs

    directs = self.directs_on_matrix_by_plan(matrix)
    # here i sum one if the last user on matrix its a direct from the matrix
    directs = self.directs_on_matrix_by_plan(matrix) + 1 if matrix.user.uuid == invoice.user.parent_uuid
   
    if directs >= required_directs
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
    total       = "#{parent.id}"
    Matrix.create(user_id: parent.id, users:total, plan_id: invoice.plan.id) if parent_plan
  end

  # count how many direct users filter by plan
  def self.directs_on_matrix_by_plan(matrix)
    direct_total = matrix.user.matrices.where(plan_id: matrix.plan_id).map{ |x|
      x.users.split(",").map{ |y| y if y != '1' && User.find(y).parent_uuid === matrix.user.uuid }.compact
    }.flatten
    return direct_total.count
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