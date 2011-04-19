class Post < ActiveRecord::Base
  
   def self.facebook
    	FBGraph::Client.new(:client_id => '185181124851176', :secret_id =>'9ebcc080254926b191aaba84023743f8')
  end
  
end
