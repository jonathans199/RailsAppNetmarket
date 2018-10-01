User.create(username: 'root_code', email: 'admin@netmarketcap.com', password: '121212', password_confirmation: '121212', uuid: SecureRandom.uuid, active:true, confirmed_at: Time.now.utc, right: false, left_son: true)
TempUser.create(parent_uuid: User.first.uuid, username: 'master_admin', email: 'admin@netmarketcap.com', password: '121212', password_confirmation: '121212', uuid: SecureRandom.uuid, active:true, confirmed_at: Time.now.utc, admin: true)

Currency.create(name: 'USD', code: 11, decimals: 2)
Currency.create(name: 'BTC', code: 12, decimals: 8)
Currency.create(name: 'LTC', code: 13, decimals: 8)

Plan.create(name:'Promo', description: 'Net Trader Pack', price: 50, fees: 0, expiration_days: 600, subscription: false, daily_percent: 0.33)
Plan.create(name:'Basic', description: 'Net Trader Pack', price: 100, fees: 0, expiration_days: 600, subscription: false, daily_percent: 0.33)
Plan.create(name:'Medium', description: 'Net Trader Pack', price: 250, fees: 0, expiration_days: 600, subscription: false, daily_percent: 0.83)
Plan.create(name:'Platinum', description: 'Net Trader Pack', price: 500, fees: 0, expiration_days: 600, subscription: false, daily_percent: 1.66)
Plan.create(name:'Gold', description: 'Net Trader Pack', price: 1000, fees: 0, expiration_days: 600, subscription: false, daily_percent: 3.33)

InvoiceStatus.create(name: 'Pending', code: 11, description: 'Invoice Pending')
InvoiceStatus.create(name: 'Paid', code: 12, description: 'Invoice paid')
InvoiceStatus.create(name: 'Cancelled', code: 13, description: 'Invoice cancelada')

SubscriptionStatus.create(name: 'Active', code: 11, description: 'Subscription active')
SubscriptionStatus.create(name: 'Expired', code: 12, description: 'Subscription expired')

RewardStatus.create(name: 'Pending', code: 11, description: 'Bonus Pending')
RewardStatus.create(name: 'Paid', code: 12, description: 'Bonus paid')
RewardStatus.create(name: 'Cancelled', code: 13, description: 'Bonus cancelada')

RewardType.create(name: 'Trading Bonus', code: 11, description: 'Trading Bonus')
RewardType.create(name: 'Direct Bonus', code: 12, description: 'Direct Bonus')
RewardType.create(name: 'Binary Bonus', code: 13, description: 'Binary Bonus')
RewardType.create(name: 'Indirect Bonus', code: 14, description: 'Indirect Bonus')
RewardType.create(name: 'Matrix Bonus', code: 15, description: 'Matrix Bonus')
RewardType.create(name: 'Club Bonus', code: 16, description: 'Club Bonus')

User.create(username: 'left_leader', email: 'admin@netmarketcap.com', password: '121212', password_confirmation: '121212', uuid: SecureRandom.uuid, sponsor_uuid: User.first.uuid, parent_uuid: User.first.uuid, active:true, confirmed_at: Time.now.utc, right: false, left_son: true)
User.create(username: 'right_leader', email: 'admin@netmarketcap.com', password: '121212', password_confirmation: '121212', uuid: SecureRandom.uuid, sponsor_uuid: User.first.uuid, parent_uuid: User.first.uuid, active:true, confirmed_at: Time.now.utc, right: true, left_son: false)

WithdrawalType.create(name: 'Payout in crytpo', code: 11, description: 'Payout in crytpo currency')

WithdrawalStatus.create(name: 'Pending', code: 11, description: 'Pay out pending')
WithdrawalStatus.create(name: 'Paid', code: 12, description: 'Pay out confirmed')
WithdrawalStatus.create(name: 'Cancelled', code: 13, description: 'Pay out cancelled')
