Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' }

  authenticated :user, ->(user) { user.is_admin? } do
    root to: "admin/dashboard#index", as: :admin_root
  end

  authenticated :user, ->(user) { user.is_candidate? } do
    root to: "questions#index", as: :candidate_root
  end

  root to: "questions#index"
  resources :questions, only: [ :index ]
  patch 'submit_answer/:user_id' => 'questions#submit_answer'

  scope module: 'admin', path: 'admin' do
    get 'dashboard' => 'dashboard#index', as: :admin_dashboard

    resources :users, except: [ :show ]
    resources :questions, except: [ :show ]
    resources :results, only: [ :index ]
    resources :tests, except: [ :show ]

    get 'users/import_users' => 'users#import', as: :user_import
    post 'users/import_users' => 'users#bulk_upload', as: :user_bulk_upload
    post 'users/send_reminder_mail' => 'users#send_reminder_mail', as: :send_reminder_mail
    post 'users/send_selection_mail' => 'users#send_selection_mail', as: :send_selection_mail
    post 'users/send_rejection_mail' => 'users#send_rejection_mail', as: :send_rejection_mail

    get 'questions/import_questions' => 'questions#import', as: :question_import
    post 'questions/import_questions' => 'questions#bulk_upload', as: :question_bulk_upload
  end
end
