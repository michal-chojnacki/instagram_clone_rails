Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
        get '/main_content', to: 'content#index'
        get '/recommended_content', to: 'content#recommended'
        post '/authenticate', to: 'authenticate#sign_in'
        get '/user', to: 'user#get_user'
        post '/user', to: 'user#update'
        get '/likes', to: 'user#get_likes'
        post '/likes', to: 'user#add_like'
        get '/observing', to: 'user#get_following_status'
        post '/observing', to: 'user#change_following_status'
        post '/content', to: 'content#add'
        get '/content', to: 'content#get_user_content'
      end
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
