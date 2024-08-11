Rails.application.routes.draw do
  
   get("/", { :controller => "users", :action => "index"})
   get("/users/sign_up", { :controller => "user_authentication", :action => "sign_up_form" })      
   post("/insert_user", { :controller => "user_authentication", :action => "create"  })
   get("/users/sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
   post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
   get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
   post("/users/edit", { :controller => "user_authentication", :action => "update" })
   get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })     
   get("/users/sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
  get("/users", { :controller => "users", :action => "index"})
  get("/users/:path_id", { :controller => "users", :action => "show"})

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
 
   # Routes for the Follow request resource:
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
   get("/delete_like/:path_id", { :controller => "likes", :action => "destroy" })
 
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
   
   get("/photos/:path_id", { :controller => "photos", :action => "show" })
   
   # UPDATE
   
   post("/modify_photo/:path_id", { :controller => "photos", :action => "update" })
   
   # DELETE
   get("/delete_photo/:path_id", { :controller => "photos", :action => "destroy" })
 
   #------------------------------
 
   # Routes for the User account:
  
end
