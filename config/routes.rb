Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :client do
        resources :plans
        resources :sessions
      
        resources :invoices do
          post 'activation', to: 'invoices#update'
        end

        resources :users do 
          get 'confirm', to: 'users#confirm'
          get 'resend_token', to: 'users#resend_token'
          post 'pass_recovery', to: 'users#pass_recovery'
          get 'biggest_plan', to: 'users#biggest_plan'
        end

        resources :rewards do 
          get 'create_binary_rewards',     to: 'rewards#create_binary_rewards'
          post 'create_investment_rewards', to: 'rewards#create_investment_rewards'
        end

        scope 'subscriptions' do
          root 'subscriptions#index'
          get ':id', to: 'subscriptions#show'
          get 'user', to: 'subscriptions#index'
          post 'greatest/:username', to: 'subscriptions#greatest'
          get 'bot_bool/:username', to: 'subscriptions#bot_bool'
        end

        scope 'points' do
          post 'user/:username', to: 'points#user'
          get 'show', to: 'points#show'
          get 'total/:uuid', to: 'points#total'
          get 'bots/:uuid', to: 'points#bots'
          get 'total_rewards', to: 'points#total_rewards'
        end

        scope 'trees' do
          get 'user/:uuid', to: 'trees#show_user_subtree'
          get 'parent_user/:uuid', to: 'trees#show_parent_user_subtree'
          get 'search_user/:username', to: 'trees#show_search_user_subtree'
        end

        scope 'vaults' do
          get 'user', to: 'vaults#show'
          get 'update_direct_rewards', to: 'vaults#update_unilevel_investments_rewards'
          get 'update_binary_rewards', to: 'vaults#update_binary_rewards'
        end

        scope 'stats' do
          get 'binary', to: 'stats#binary'
          get 'investments', to: 'stats#investments'
          get 'purchases', to: 'stats#purchases'
          get 'withdrew', to: 'stats#withdrew'
          get 'referrals', to: 'stats#referrals'
          get 'residual_bonus', to: 'stats#residual_bonus'
          get 'residual_withdrawal', to: 'stats#residual_withdrawal'
          get 'residual_mining', to: 'stats#residual_mining'
        end

        scope 'withdrawals' do
          get 'set_view', to: 'withdrawals#set_view'
          post 'new', to: 'withdrawals#create'
        end
      end
    

      namespace :admin do
        resources :users
        resources :temp_users
        resources :courses
        resources :units
        resources :sessions
        
        resources :invoices do
          post 'activation', to: 'invoices#update'
        end
        
        scope 'withdrawals' do
          get 'pending_requests', to: 'withdrawals#pending'
          get 'approved_requests', to: 'withdrawals#approved'
          post 'convert/:settle', to: 'withdrawals#convert'
          patch 'pay/:uuid', to: 'withdrawals#update'
          delete ':id', to: 'withdrawals#destroy'
        end

        scope 'reports' do
          post 'users', to: 'reports#users'
          post 'invoices', to: 'reports#invoices'
          post 'invoices/group', to: 'reports#invoices_group'
        end 
      end

    end
  end
end