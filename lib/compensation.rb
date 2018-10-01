module Compensation
  def self.matrix(user)
    matrix = Matrix.where(reedemed: false)
    matrix.map { |x| 
      total = "#{x.users.to_s},#{user.id}"
      x.update(users: "#{total}")
      x.update(reedemed: true) if total.split(",").count == 14
    }
  end

  def self.first_matrix(invoice)
    parent  = User.where(uuid:invoice.user.parent_uuid).select(:id,:uuid).last
    counter = User.where(parent_uuid: parent.uuid).select(:id).count
    Matrix.create(user_id: parent.id, users:"#{invoice.user.id}") if counter == 2
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

  # update user points depending on the current invoice paid
  def self.update_binary_points(user, subs, invoice, user_existence)
    if !invoice.plan.subscription
      if user.ancestry_depth > 0
        direct_parent = User.find_by(uuid: user.sponsor_uuid)
        direct_parent = User.find_by(uuid: temp_user.uuid).ancestors.at_depth(0).first if !direct_parent
        parents = user.ancestors
        value   = subs.price
        parents.each do |parent|
          active_plans = true if parent.subscriptions.map { |x| x.plan_id if x.subscription_status_id == 11  }.compact.count > 0
          if active_plans
            if parent.children[0].descendants.where(uuid: user.uuid).exists? || parent.children[0].uuid == user.uuid
              if parent.children[0].left_son == true
                parent.point.left_total_points += value.to_i
                parent.point.left_points += value.to_i
              else
                parent.point.right_total_points += value.to_i
                parent.point.right_points += value.to_i
              end
            else
              if parent.children[1].left_son == true
                parent.point.left_total_points += value.to_i
                parent.point.left_points += value.to_i
              else
                parent.point.right_total_points += value.to_i
                parent.point.right_points += value.to_i
              end
            end
            parent.point.right_total_points > parent.point.left_total_points ? parent.point.diff = parent.point.right_total_points - parent.point.left_total_points : parent.point.diff = parent.point.left_total_points - parent.point.right_total_points
            parent.point.save
          end
        end
      end
    end
  end
end