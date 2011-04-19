class PostsController < ApplicationController

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    
    facebook = Post.facebook
    
    facebook.selection.page(@post.page_id).feed.info!["data"].each do |feed|
      status = Feed.new
      status.feed_id = feed["id"]
      status.picture = facebook.selection.user(feed["from"]["id"]).picture
      status.link = facebook.selection.user(feed["from"]["id"]).info!["link"]
      
      if feed.comments
        status.comments = ActiveSupport::JSON.encode(feed.comments["data"])
      end  
      
      status.save
    end
    
    @post.feed = ActiveSupport::JSON.encode(facebook.selection.page(@post.page_id).feed.info!["data"])
    
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
end
