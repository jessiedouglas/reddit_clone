class PostsController < ApplicationController
  before_filter :ensure_author, only: [:edit, :update]

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments.includes(:author)
    render :show
  end

  def new
    @sub = Sub.find(params[:sub_id])
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:errors] = ["Post made!"]
      redirect_to post_url(@post)
    else
      fail
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if params[:sub_ids].nil?
      @post.sub_ids = []
    end
    if @post.update(post_params)
      flash[:errors] = ["Post edited!"]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def ensure_author
    post = Post.find(params[:id])
    if post.author != current_user
      flash[:errors] = ["Nacho post"]
      redirect_to post_url(post)
    end
  end
end
