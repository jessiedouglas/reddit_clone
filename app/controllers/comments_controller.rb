class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment =
    @comment = Comment.new
    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:errors] = ["Comment added!"]
      redirect_to post_url(@comment.post)
    else
      @post = Post.find(comment_params[:post_id])
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.content = "[deleted]"
    redirect_to post_url(@comment.post)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
