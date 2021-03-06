Rails.application.routes.draw do

    root to: 'homes#top'
    get 'home/about' => 'homes#about'

    get 'bookmarks/create'
    get 'bookmarks/destroy'

    devise_for :users
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    resources :users

    resources :articles do
        resource  :favorites, only: [:create, :destroy]
        resources :post_comments, only: [:create, :edit, :update, :destroy]
        resource  :bookmarks, only: [:create, :destroy]

        # ブックマークの一覧表示に使用するルーティング
        get			:bookmarks, on: :collection

    end

    resources :questions do
        resources :answers, only: [:create, :edit, :update, :destroy]
        resource  :sympathizes, only: [:create, :destroy]
    end

end
