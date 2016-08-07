class CommentsController < ApplicationController
  before_action :require_login!

  def new
    @post_id = params[:post_id]
    @post = Post.find_by_id(cookies[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find_by_id(params[:id])
    @post = Post.find_by_id(cookies[:post_id])
  end

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content, :comment_id)
  end

  def vote(value)
    @comment = Comment.find(params[:id])
    @vote = Vote.find_by(
      votable_id: @comment.id, votable_type: "Comment", user_id: current_user.id
    )

    if @vote
      @vote.update(value: value)
    else
      @comment.votes.create!(
        user_id: current_user.id, value: value
      )
    end

    redirect_to post_url(cookies[:post_id])
  end

end
