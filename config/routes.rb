Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
        get '/main_content', to: 'content#index'
        get '/recommended_content', to: 'content#recommended'
        post '/authenticate', to: 'authenticate#sign_in'
        get '/user', to: 'user#get_user'
        post '/user', to: 'user#update'
      end
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
