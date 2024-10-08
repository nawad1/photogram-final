Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  
  root to: "users#index"
    get("/users", {:controller => "users", :action => "index"})
  

     # Routes for the User account:
  
    # SIGN UP FORM
    get("/users/sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
    # CREATE RECORD
    post("/insert_user", { :controller => "user_authentication", :action => "create"  })
        
    # EDIT PROFILE FORM        
    get("/users/edit", { :controller => "user_authentication", :action => "edit_profile_form" }) 
       
    # UPDATE RECORD
    post("/edit_user", { :controller => "user_authentication", :action => "update" })
    
    # DELETE RECORD
    get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })
  
    # ------------------------------
  
    # SIGN IN FORM
    get("/users/sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
    # AUTHENTICATE AND STORE COOKIE
    post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
    
    # SIGN OUT        
    get("/users/sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })

    get("/users/:username", { :controller => "users", :action => "show" })

    # Routes for the Comment resource:
  
    # CREATE
    post("/insert_comment", { :controller => "comments", :action => "create" })
            
    # READ
    get("/comments", { :controller => "comments", :action => "index" })
    
    get("/comments/:path_id", { :controller => "comments", :action => "show" })
    
    # UPDATE
    
    post("/modify_comment/:path_id", { :controller => "comments", :action => "update" })
    
    # DELETE
    get("/delete_comment/:path_id", { :controller => "comments", :action => "destroy" })
  
    #------------------------------
  get '/users/:username/feed', to: 'users#feed', as: 'user_feed'
  # config/routes.rb
get '/users/:username/liked_photos', to: 'users#liked_photos', as: 'user_liked_photos'
# config/routes.rb
get '/users/:username/discover', to: 'users#discover', as: 'user_discover'

    # Routes for the Follow request resource:
    resources :users do
      member do
        get 'liked_photos', to: 'users#liked_photos'
        get 'discovery', to: 'users#discovery'
        post 'follow', to: 'users#follow'
        delete 'unfollow', to: 'users#unfollow'
      end
    end
    # CREATE
    post("/insert_follow_request", { :controller => "follow_requests", :action => "create" })
            
    # READ
    get("/follow_requests", { :controller => "follow_requests", :action => "index" })
    
    get("/follow_requests/:path_id", { :controller => "follow_requests", :action => "show" })
    
    # UPDATE
    
    post("/modify_follow_request/:path_id", { :controller => "follow_requests", :action => "update" })
    
    # DELETE
    get("/delete_follow_request/:path_id", { :controller => "follow_requests", :action => "destroy" })
    delete '/cancel_request/:user_id', to: 'users#cancel_request', as: 'cancel_request'
  
    #------------------------------
  
    # Routes for the Like resource:
    
    # CREATE
    post("/insert_like", { :controller => "likes", :action => "create" })
            
    # READ
    get("/likes", { :controller => "likes", :action => "index" })
    
    get("/likes/:path_id", { :controller => "likes", :action => "show" })
    
    # UPDATE
    
    post("/modify_like/:path_id", { :controller => "likes", :action => "update" })
    
    # DELETE
    get("/delete_like", { :controller => "likes", :action => "destroy" })
  
    #------------------------------
  
    # Routes for the Photo resource:
    resources :users do
      member do
        get 'liked_photos', to: 'users#liked_photos'
        get 'feed', to: 'users#feed'
        get 'discovery', to: 'users#discovery'
        post 'follow', to: 'users#follow'
        delete 'unfollow', to: 'users#unfollow'
      end
    end
    # CREATE
    post("/insert_photo", { :controller => "photos", :action => "create" })
            
    # READ
    get("/photos", { :controller => "photos", :action => "index" })
    post("/photos", { :controller => "photos", :action => "index" })
    get("/photos/:path_id", { :controller => "photos", :action => "show" })
    
    # UPDATE
    
    post("/modify_photo/:path_id", { :controller => "photos", :action => "update" })
    
    # DELETE
    get("/delete_photo/:path_id", { :controller => "photos", :action => "destroy" })
  
    #------------------------------
  
   
               
    #------------------------------
  
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
