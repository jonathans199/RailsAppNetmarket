User.create(username: 'root_code', email: 'admin@wavestrading.us', password: '121212', password_confirmation: '121212', uuid: SecureRandom.uuid, active:true, confirmed_at: Time.now.utc, right: false, left_son: true)
TempUser.create(parent_uuid: User.first.uuid, username: 'master_admin', email: 'admin@wavestrading.us', password: '121212', password_confirmation: '121212', uuid: SecureRandom.uuid, active:true, confirmed_at: Time.now.utc, admin: true)

Currency.create(name: 'USD', code: 11, decimals: 2)
Currency.create(name: 'BTC', code: 12, decimals: 8)
Currency.create(name: 'LTC', code: 13, decimals: 8)

Plan.create(name:'Trader Pack', description: 'Investment plan', price: 50, fees: 0, expiration_days: 600, subscription: false, daily_percent: 1.5)

InvoiceStatus.create(name: 'Pending', code: 11, description: 'Invoice Pending')
InvoiceStatus.create(name: 'Paid', code: 12, description: 'Invoice paid')
InvoiceStatus.create(name: 'Cancelled', code: 13, description: 'Invoice cancelada')

SubscriptionStatus.create(name: 'Active', code: 11, description: 'Subscription active')
SubscriptionStatus.create(name: 'Expired', code: 12, description: 'Subscription expired')

RewardStatus.create(name: 'Pending', code: 11, description: 'Reward Pending')
RewardStatus.create(name: 'Paid', code: 12, description: 'Reward paid')
RewardStatus.create(name: 'Cancelled', code: 13, description: 'Reward cancelada')

RewardType.create(name: 'Daily mining Bonus', code: 11, description: 'Daily mining Bonus')
RewardType.create(name: 'Fast Bonus', code: 12, description: 'Fast Bonus')
RewardType.create(name: 'Binary bonus', code: 13, description: 'Reward for binary')
RewardType.create(name: 'Residual Bonus', code: 14, description: 'Residual Bonus')

User.create(username: 'left_leader', email: 'admin@wavestrading.us', password: '121212', password_confirmation: '121212', uuid: SecureRandom.uuid, sponsor_uuid: User.first.uuid, parent_uuid: User.first.uuid, active:true, confirmed_at: Time.now.utc, right: false, left_son: true)
User.create(username: 'right_leader', email: 'admin@wavestrading.us', password: '121212', password_confirmation: '121212', uuid: SecureRandom.uuid, sponsor_uuid: User.first.uuid, parent_uuid: User.first.uuid, active:true, confirmed_at: Time.now.utc, right: true, left_son: false)

WithdrawalType.create(name: 'Withdrawal in crypto', code: 11, description: 'withdrawal in crypto currency')

WithdrawalStatus.create(name: 'Pending', code: 11, description: 'Withdrawal pending')
WithdrawalStatus.create(name: 'Paid', code: 12, description: 'Withdrawal confirmed')
WithdrawalStatus.create(name: 'Cancelled', code: 13, description: 'Withdrawal cancelled')
