Amplifize::Application.routes.draw do

  match '/login' => 'user_sessions#create', :as => :login
  match '/logout' => 'user_sessions#destroy', :as => :logout

  #Logged in state pages
  match '/my/homepage' => 'users#homepage', :as => :homepage
  match '/my/content' => 'users#content', :as => :content
  match '/my/conversations' => 'users#conversations', :as => :conversations
  match '/my/conversations/search' => 'shares#search', :as => :share_search
  match '/my/people' => 'users#people', :as => :people

  match '/my/profile' => 'users#profile', :as => :profile, :via => :get
  match '/my/profile' => 'users#update', :as => :update_profile, :via => :put

  #Logged in content retrieval
  match '/post_users/', :controller => 'post_users', :action => 'retrieve', :as => :retrieve_posts
  match '/share_users/', :controller => 'share_users', :action => 'retrieve', :as => :retrieve_conversations

  #People actions
  match '/users/search' => 'users#search', :as => :user_search

  #Import 3rd-party content stack
  match '/feeds/import' => 'import#import', :as => :import
  match '/feeds/import/import' => 'import#do_import', :as => :import_import
  match '/feeds/import/opml' => 'import#opml', :as => :import_opml

  #Feed based actions
  match '/my/feeds/' => 'feeds#manage', :as => :feeds_manage

  match '/feeds/clear-all' => 'feeds#clearAll'
  match '/feeds/:feed_id/tags' => 'feeds#tagsByFeed'
  match '/feeds/:feed_id/unsubscribe/' => 'users#unsubscribe', :as => :unsubscribe

  match '/post_users/:post_id/read_state/:state', :controller => 'post_users', :action => 'set_read_state'
  match '/share_users/:share_id/read_state/:state', :controller => 'share_users', :action => 'set_read_state'

  match '/tags/:tag_name/feeds', :controller => 'tags', :action => 'get_feeds'

  resources :users do
    get :autocomplete_tag_name, :on => :collection
  end

  #Share bookmarklet actions
  match '/ext/share/prompt(/:api_version)/:user_credentials' => 'bookmarklet#share_prompt', :as => :ext_share_prompt
  match '/ext/share/:api_version/:user_credentials' => 'bookmarklet#share', :as => :ext_share

  #Subscribe bookmarklet actions
  match '/ext/sub(/:api_version)/:user_credentials' => 'bookmarklet#sub', :as => :ext_sub

  #follows actions
  match '/follows/:user_id/add' => 'follows#add', :as => :follows_add
  match '/follows/:user_id/unsubscribe' => 'follows#unsubscribe', :as => :unsubscribe_person

  #share actions
  match '/shares/add/' => 'shares#add', :as => :shares_add
  match '/shares/add-by-link' => 'shares#add_by_link', :as => :shares_add_by_link

  #invite actions
  match '/invite/create' => 'invite#create', :as => :invite_create
  match '/invite/respond/:invite_id' => 'invite#respond', :as => :invite_respond

  match '/about' => 'home#about', :as => :about
  match '/contact' => 'home#contact', :as => :contact
  match '/terms' => 'home#terms', :as => :terms
  match '/privacy' => 'home#privacy', :as => :privacy

  resources :users, :user_sessions, :feeds, :posts, :shares, :comments, :tags, :invites, :password_resets

  root :to => "home#index"

  match '/googleaf23107439d49301.html' => 'home#google_verification'
  match '/EA7D0B988A3987A3DE173BDF8E3A4015.txt' => 'home#cert_verification'

end
